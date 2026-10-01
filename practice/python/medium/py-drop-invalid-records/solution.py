# Xom Data · Drop records missing a required field
# Problem: https://xomdata.com/practice/py-drop-invalid-records
# Solved: 2026-10-01

def keep_valid(rows, required):
    def is_valid(row):
        for key in required:
            if key not in row:
                return False
            value = row[key]
            if value is None:
                return False
            if isinstance(value, str) and value.strip() == "":
                return False
        return True
    
    return [row for row in rows if is_valid(row)]
