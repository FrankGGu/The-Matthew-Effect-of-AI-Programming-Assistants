class Solution:
    def averageValue(self, nums: List[int]) -> int:
        total = 0
        count = 0
        for num in nums:
            if num % 6 == 0:
                total += num
                count += 1
        return total // count if count > 0 else 0