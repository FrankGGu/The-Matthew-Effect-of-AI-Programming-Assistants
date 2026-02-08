class Solution:
    def maxSum(self, nums: List[int]) -> int:
        from collections import defaultdict
        import math

        def get_gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        def get_lcm(a, b):
            return a * b // get_gcd(a, b)

        freq = defaultdict(int)
        for num in nums:
            freq[num] += 1

        res = 0
        for num in freq:
            count = freq[num]
            if count == 1:
                res += num
            else:
                lcm = num
                for i in range(2, count + 1):
                    lcm = get_lcm(lcm, num * i)
                res += lcm

        return res