class Solution:
    def differenceOfSums(self, nums: List[int], k: int) -> int:
        sum_divisible = 0
        sum_non_divisible = 0
        for num in nums:
            if num % k == 0:
                sum_divisible += num
            else:
                sum_non_divisible += num
        return sum_non_divisible - sum_divisible