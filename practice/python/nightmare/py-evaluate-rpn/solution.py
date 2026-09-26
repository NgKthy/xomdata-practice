# Xom Data · Evaluate reverse polish notation
# Problem: https://xomdata.com/practice/py-evaluate-rpn
# Solved: 2026-09-26

def eval_rpn(tokens):
    stack = []
    for token in tokens:
        if token in {"+", "-", "*", "/"}:
            b = stack.pop()
            a = stack.pop()
            if token == "+":
                stack.append(a + b)
            elif token == "-":
                stack.append(a - b)
            elif token == "*":
                stack.append(a * b)
            else:  
                q = abs(a) // abs(b)
                if (a < 0) ^ (b < 0):
                    q = -q
                stack.append(q)
        else:
            stack.append(int(token))
    return stack[-1]
