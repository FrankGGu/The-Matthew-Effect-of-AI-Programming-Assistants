from typing import List

class Solution:
    def minAbsSum(self, nums: List[int], target: int) -> int:
        def subset_sums(nums):
            n = len(nums)
            left = []
            right = []
            for i in range(n // 2):
                left.append(nums[i])
            for i in range(n // 2, n):
                right.append(nums[i])
            left_sums = [0]
            for num in left:
                temp = []
                for s in left_sums:
                    temp.append(s + num)
                left_sums += temp
            right_sums = [0]
            for num in right:
                temp = []
                for s in right_sums:
                    temp.append(s + num)
                right_sums += temp
            return left_sums, right_sums

        left_sums, right_sums = subset_sums(nums)
        right_sums.sort()
        min_diff = float('inf')
        for s in left_sums:
            low = 0
            high = len(right_sums) - 1
            while low <= high:
                mid = (low + high) // 2
                total = s + right_sums[mid]
                diff = abs(total - target)
                if diff < min_diff:
                    min_diff = diff
                if total < target:
                    low = mid + 1
                else:
                    high = mid - 1
        return min_diff