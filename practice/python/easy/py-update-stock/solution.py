# Xom Data · Add goods into the stock table
# Problem: https://xomdata.com/practice/py-update-stock
# Solved: 2026-08-31

def add_stock(stock, code, qty):
    stock[code] = stock.get(code, 0) + qty
    return stock
