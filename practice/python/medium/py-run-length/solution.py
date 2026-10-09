# Xom Data · String compression
# Problem: https://xomdata.com/practice/py-run-length
# Solved: 2026-10-09

def run_length_encode(text):
    if not text:
        return ""
    
    result = []
    count = 1
    
    for i in range(1, len(text)):
        if text[i] == text[i - 1]:
            count += 1
        else:
            result.append(text[i - 1] + str(count))
            count = 1
    
    result.append(text[-1] + str(count))
    return ''.join(result)
