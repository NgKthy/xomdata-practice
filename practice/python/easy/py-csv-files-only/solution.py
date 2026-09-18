# Xom Data · Pick the data files out of a download folder
# Problem: https://xomdata.com/practice/py-csv-files-only
# Solved: 2026-09-18

def csv_files(names):
    return [name for name in names if name.endswith(".csv")]
