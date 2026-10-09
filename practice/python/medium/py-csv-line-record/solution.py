# Xom Data · Match a CSV line to its column names
# Problem: https://xomdata.com/practice/py-csv-line-record
# Solved: 2026-10-09

def to_record(header, line):
    values = line.split(',')
    return {
        col: values[i] if i < len(values) else ''
        for i, col in enumerate(header)
    }
