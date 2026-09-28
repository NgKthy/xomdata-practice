#!/usr/bin/env python3
"""
portfolio/scripts/generate_stats.py
READ-ONLY on practice/. Scans solution files & manifest to produce portfolio/data/data.json.
"""
from __future__ import annotations

import json
import os
import re
import subprocess
from collections import defaultdict
from datetime import datetime, timezone, date, timedelta
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PRACTICE  = REPO_ROOT / "practice"
OUTPUT    = REPO_ROOT / "portfolio" / "data" / "data.json"

LANG_MAP = {
    ".py": "python",
    ".sql": "sql",
    ".ipynb": "python",
    ".xlsx": "excel",
    ".csv": "excel"
}

DIFFICULTIES = ["easy", "medium", "hard", "nightmare"]

def detect_difficulty_and_lang(rel: Path) -> tuple[str, str]:
    parts = [p.lower() for p in rel.parts]
    lang = "other"
    if "python" in parts:
        lang = "python"
    elif "sql" in parts:
        lang = "sql"
    else:
        ext = rel.suffix.lower()
        lang = LANG_MAP.get(ext, "other")

    diff = "medium"
    for d in DIFFICULTIES:
        if d in parts:
            diff = d
            break

    return diff, lang

def detect_category(name: str, rel: Path, content: str) -> str:
    rel_str = rel.as_posix().lower()
    name_lower = name.lower()

    if rel_str.startswith("practice/python"):
        if rel.name.startswith("pd-") or "pandas" in name_lower or "dataframe" in content.lower():
            return "Pandas Data Prep"
        if "tree" in name_lower or "graph" in name_lower or "dfs" in name_lower or "bfs" in name_lower:
            return "Trees & Graphs"
        if "dp" in name_lower or "dynamic" in name_lower or "palindrome" in name_lower or "subsequence" in name_lower:
            return "Dynamic Programming"
        if "matrix" in name_lower or "array" in name_lower or "string" in name_lower or "search" in name_lower:
            return "Data Structures & Algos"
        return "Python Data Logic"

    if rel_str.startswith("practice/sql"):
        if "join" in name_lower or "leftjoin" in name_lower:
            return "SQL Joins & Relational"
        if "groupby" in name_lower or "sum" in name_lower or "avg" in name_lower or "count" in name_lower or "having" in name_lower:
            return "SQL Aggregations"
        if "cohort" in name_lower or "retention" in name_lower or "churn" in name_lower or "rfm" in name_lower or "mrr" in name_lower:
            return "Advanced Analytics & Cohorts"
        if "window" in name_lower or "rank" in name_lower or "lead" in name_lower or "lag" in name_lower or "partition" in name_lower:
            return "SQL Window Functions"
        return "SQL Querying"

    return "General Practice"

def parse_file_header(filepath: Path) -> tuple[str, str | None, str | None]:
    """Extracts title, problem_url, and solved_date from file header comments."""
    title = filepath.parent.name.replace("-", " ").replace("_", " ").title()
    url = None
    solved_date = None

    try:
        content = filepath.read_text(encoding="utf-8", errors="ignore")
        for line in content.splitlines()[:10]:
            line_str = line.strip()
            # Title comment e.g. # Xom Data · Convert temperature to Fahrenheit
            if "Xom Data ·" in line_str:
                parts = line_str.split("Xom Data ·", 1)
                if len(parts) > 1 and parts[1].strip():
                    title = parts[1].strip()

            # URL e.g. # Problem: https://xomdata.com/practice/py-celsius-to-f
            if "Problem:" in line_str:
                match = re.search(r'https?://[^\s]+', line_str)
                if match:
                    url = match.group(0)

            # Date e.g. # Solved: 2026-09-27
            if "Solved:" in line_str:
                match = re.search(r'\d{4}-\d{2}-\d{2}', line_str)
                if match:
                    solved_date = match.group(0)

    except Exception:
        pass

    return title, url, solved_date

def git_first_commit_date(file_path: Path) -> str | None:
    try:
        out = subprocess.check_output(
            ["git", "log", "--diff-filter=A", "--follow",
             "--format=%aI", "--", str(file_path.relative_to(REPO_ROOT))],
            cwd=REPO_ROOT, stderr=subprocess.DEVNULL, text=True,
        ).strip().splitlines()
        return out[-1][:10] if out else None
    except Exception:
        return None

def compute_streak(activity: dict[str, int]) -> int:
    if not activity:
        return 0
    days = sorted(activity.keys(), reverse=True)
    today = datetime.now(timezone.utc).date().isoformat()
    start = date.fromisoformat(today)
    if today not in activity:
        start = start - timedelta(days=1)
    
    streak = 0
    while start.isoformat() in activity:
        streak += 1
        start = start - timedelta(days=1)
    return streak

def scan() -> dict:
    by_lang     = defaultdict(int)
    by_diff     = defaultdict(int)
    by_category = defaultdict(int)
    activity    = defaultdict(int)
    monthly_trend = defaultdict(int)
    solutions   = []

    if PRACTICE.exists():
        for f in PRACTICE.rglob("*"):
            if not f.is_file():
                continue
            if f.suffix.lower() not in ('.py', '.sql', '.ipynb'):
                continue

            rel = f.relative_to(REPO_ROOT)
            diff, lang = detect_difficulty_and_lang(rel)

            title, url, solved_date = parse_file_header(f)
            if not url:
                url = f"https://github.com/NgKthy/xomdata-practice/blob/main/{rel.as_posix()}"
            
            if not solved_date:
                solved_date = git_first_commit_date(f) or "2026-09-28"

            category = detect_category(title, rel, f.read_text(encoding="utf-8", errors="ignore"))

            by_lang[lang] += 1
            by_diff[diff] += 1
            by_category[category] += 1
            if solved_date:
                activity[solved_date] += 1
                month_key = solved_date[:7]
                monthly_trend[month_key] += 1

            solutions.append({
                "name":       title,
                "slug":       f.parent.name,
                "file":       rel.as_posix(),
                "lang":       lang,
                "difficulty": diff,
                "category":   category,
                "date":       solved_date,
                "url":        url,
            })

    solutions.sort(key=lambda x: (x["date"] or "", x["name"]), reverse=True)

    try:
        commit = subprocess.check_output(
            ["git", "rev-parse", "--short", "HEAD"],
            cwd=REPO_ROOT, text=True
        ).strip()
    except Exception:
        commit = "unknown"

    total_solutions = len(solutions)
    unique_challenges = len({s["slug"] for s in solutions})

    sorted_trend = [{"month": m, "count": monthly_trend[m]} for m in sorted(monthly_trend.keys())]

    return {
        "generated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "source_commit": commit,
        "totals": {
            "accepted":   total_solutions,
            "challenges": unique_challenges,
            "languages":  len(by_lang),
            "streak":     compute_streak(activity),
            "synced":     f"{total_solutions} / {total_solutions}",
            "grand":      total_solutions,
        },
        "by_language":  dict(by_lang),
        "by_difficulty": {d: by_diff.get(d, 0) for d in DIFFICULTIES},
        "by_category":  dict(by_category),
        "trend":        sorted_trend,
        "activity":     dict(activity),
        "solutions":    solutions,
    }

if __name__ == "__main__":
    data = scan()
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"[OK] {data['totals']['grand']} solutions scan completed -> {OUTPUT.relative_to(REPO_ROOT)}")
