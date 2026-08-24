# Xom Data · Merge intervals
# Problem: https://xomdata.com/practice/py-merge-intervals
# Solved: 2026-08-24

def merge_intervals(intervals):
    if not intervals:
        return []

    intervals.sort(key=lambda x: x[0])

    merged = []
    current_start, current_end = intervals[0]

    for start, end in intervals[1:]:
        if start <= current_end:
            current_end = max(current_end, end)
        else:
            merged.append([current_start, current_end])
            current_start, current_end = start, end
    
    merged.append([current_start, current_end])
    return merged
