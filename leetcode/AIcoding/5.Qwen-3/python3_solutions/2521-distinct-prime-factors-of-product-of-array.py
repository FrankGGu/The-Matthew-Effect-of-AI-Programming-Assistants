class Solution:
    def distinct_prime_factors(self, nums):
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5)+1):
                if n % i == 0:
                    return False
            return True

        prime_set = set()
        product = 1
        for num in nums:
            product *= num

        for i in range(2, int(product**0.5) + 1):
            if product % i == 0 and is_prime(i):
                prime_set.add(i)
                while product % i == 0:
                    product //= i

        if product > 1 and is_prime(product):
            prime_set.add(product)

        return len(prime_set)