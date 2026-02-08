class Solution:
    def mostFrequentPrime(self, nums: List[int]) -> int:
        from collections import defaultdict

        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        freq = defaultdict(int)
        for num in nums:
            s = str(num)
            for i in range(len(s)):
                for j in range(i + 1, len(s) + 1):
                    sub = int(s[i:j])
                    if is_prime(sub):
                        freq[sub] += 1

        max_freq = -1
        result = -1
        for key in freq:
            if freq[key] > max_freq or (freq[key] == max_freq and key < result):
                max_freq = freq[key]
                result = key
        return result