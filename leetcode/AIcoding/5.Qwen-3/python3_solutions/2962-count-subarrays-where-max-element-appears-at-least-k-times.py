from collections import defaultdict

class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int
        max_num = max(nums)
        count = defaultdict(int)
        count[0] = 1
        res = 0
        curr = 0
        for num in nums:
            if num == max_num:
                curr += 1
            res += count[curr - k]
            count[curr] += 1
        return res