class Solution:
    def minElement(self, nums: List[int]) -> int:
        def digit_sum(n):
            s = 0
            while n > 0:
                s += n % 10
                n //= 10
            return s

        min_val = float('inf')
        for num in nums:
            s = digit_sum(num)
            min_val = min(min_val, s)
        return min_val