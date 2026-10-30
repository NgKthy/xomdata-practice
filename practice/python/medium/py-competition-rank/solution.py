# Xom Data · Assign ranks with ties to runners
# Problem: https://xomdata.com/practice/py-competition-rank
# Solved: 2026-10-30

def ranks(scores):
    sorted_scores = sorted(scores, reverse=True)
    rank_map = {}
    for i, score in enumerate(sorted_scores):
        if score not in rank_map:
            rank_map[score] = i + 1
    return [rank_map[score] for score in scores]
