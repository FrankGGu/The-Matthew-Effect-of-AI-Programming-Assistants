from collections import defaultdict

class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        count = defaultdict(int)
        count[0] = 1
        res = 0
        curr = 0
        for num in nums:
            curr += 1 if num > k else -1
            res += count[curr]
            count[curr] += 1
        return res