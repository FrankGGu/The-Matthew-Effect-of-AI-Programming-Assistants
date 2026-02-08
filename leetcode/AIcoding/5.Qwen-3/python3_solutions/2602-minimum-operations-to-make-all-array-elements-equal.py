class Solution:
    def minOperations(self, nums: List[int]) -> int:
        from collections import Counter
        count = Counter(nums)
        n = len(nums)
        for num, freq in count.items():
            if freq > n // 2:
                return n - freq
        return 0