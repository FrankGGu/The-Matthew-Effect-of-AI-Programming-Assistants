class Solution:
    def maxOperations(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0
        from collections import defaultdict

        count = defaultdict(int)
        for i in range(n):
            for j in range(i + 1, n):
                s = nums[i] + nums[j]
                count[s] += 1
        return max(count.values())