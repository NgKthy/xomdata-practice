# Xom Data · Count primes less than N
# Problem: https://xomdata.com/practice/py-count-primes
# Solved: 2026-09-18

def count_primes(n):
    if n < 2:
        return 0

    is_prime = [True] * n
    is_prime[0] = is_prime[1] = False

    for i in range(2, int(n ** 0.5) + 1):
        if is_prime[i]:
            for j in range(i * i, n, i):
                is_prime[j] = False

    return sum(is_prime)
