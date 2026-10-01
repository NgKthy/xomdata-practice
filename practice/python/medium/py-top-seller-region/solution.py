# Xom Data · Top-selling employee per region
# Problem: https://xomdata.com/practice/py-top-seller-region
# Solved: 2026-10-01

def top_seller(records):
    totals = {}    
    first_idx = {}  
    best = {}    

    for idx, (region, employee, sales) in enumerate(records):
        if region not in totals:
            totals[region] = {}
            first_idx[region] = {}
            best[region] = (None, -1, float('inf'))

        if employee not in totals[region]:
            totals[region][employee] = 0
            first_idx[region][employee] = idx

        totals[region][employee] += sales

        cur_total = totals[region][employee]
        cur_first = first_idx[region][employee]
        best_emp, best_total, best_first = best[region]

        if cur_total > best_total or (cur_total == best_total and cur_first < best_first):
            best[region] = (employee, cur_total, cur_first)

    return {region: best[region][0] for region in totals}
