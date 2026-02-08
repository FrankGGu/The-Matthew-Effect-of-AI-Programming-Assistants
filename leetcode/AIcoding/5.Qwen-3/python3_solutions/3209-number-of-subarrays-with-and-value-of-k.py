class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        count = 0
        prefix = 0
        from collections import defaultdict
        map = defaultdict(int)
        map[0] = 1
        for num in nums:
            prefix ^= num
            count += map[prefix ^ k]
            map[prefix] += 1
        return count