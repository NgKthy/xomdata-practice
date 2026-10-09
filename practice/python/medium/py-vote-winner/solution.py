# Xom Data · Voting winner
# Problem: https://xomdata.com/practice/py-vote-winner
# Solved: 2026-10-09

def vote_winner(votes):
    counts = {}
    first_seen = {}
    for i, name in enumerate(votes):
        if name not in counts:
            counts[name] = 0
            first_seen[name] = i
        counts[name] += 1

    return max(counts, key=lambda name: (counts[name], -first_seen[name]))
