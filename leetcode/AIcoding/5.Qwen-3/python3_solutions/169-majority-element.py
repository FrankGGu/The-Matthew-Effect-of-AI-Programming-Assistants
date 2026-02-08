class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        from collections import Counter
        counts = Counter(nums)
        for num, count in counts.items():
            if count > len(nums) // 2:
                return num