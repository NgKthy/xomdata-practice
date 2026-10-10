# Xom Data · Split an ISO date string into parts
# Problem: https://xomdata.com/practice/py-parse-date-parts
# Solved: 2026-10-10

def date_parts(text):
    year, month, day = text.split("-")
    return (int(year), int(month), int(day))
