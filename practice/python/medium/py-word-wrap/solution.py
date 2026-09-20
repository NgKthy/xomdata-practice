# Xom Data · Wrap a description for a narrow box
# Problem: https://xomdata.com/practice/py-word-wrap
# Solved: 2026-09-20

def wrap_text(text, width):
    if not text:
        return []

    words = text.split()
    lines = []
    current = ""

    for word in words:
        if current == "":
            current = word
        elif len(current) + 1 + len(word) <= width:
            current += " " + word
        else:
            lines.append(current)
            current = word

    if current:
        lines.append(current)

    return lines
