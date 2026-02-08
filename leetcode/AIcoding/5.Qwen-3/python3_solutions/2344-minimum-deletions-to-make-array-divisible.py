class Solution:
    def minDeletions(self, nums: List[int], numsDivide: List[int]) -> int:
        from collections import Counter

        def get_prime_factors(x):
            i = 2
            factors = set()
            while i * i <= x:
                if x % i == 0:
                    factors.add(i)
                    while x % i == 0:
                        x //= i
                i += 1
            if x > 1:
                factors.add(x)
            return factors

        num_freq = Counter(nums)
        prime_factors = get_prime_factors(numsDivide[0])

        for factor in sorted(prime_factors):
            if factor in num_freq:
                return num_freq[factor]

        return -1