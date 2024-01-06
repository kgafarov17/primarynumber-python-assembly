def sieve_of_eratosthenes(limit)
    primes = []
    is_prime = [True]  (limit + 1)
    is_prime[0] = is_prime[1] = False

    for number in range(2, int(limit0.5) + 1)
        if is_prime[number]
            primes.append(number)
            for multiple in range(number  number, limit + 1, number)
                is_prime[multiple] = False

    for number in range(int(limit0.5) + 1, limit + 1)
        if is_prime[number]
            primes.append(number)

    return primes

upper_limit = 99999 # Set the upper limit for prime numbers

# Generate prime numbers within the specified range
prime_numbers = sieve_of_eratosthenes(upper_limit)

print(Prime numbers in the range 1 to, upper_limit, are)
print(prime_numbers)