class Solution:
    def isPossibleToMakeSumZero(self, nums: List[int], queries: List[List[int]]) -> bool:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        for l, r in queries:
            total = prefix[r] - prefix[l - 1]
            if total % 2 != 0:
                return False
        return True