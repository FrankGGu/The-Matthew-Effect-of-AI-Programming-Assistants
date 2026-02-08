class Solution:
    def maxNumberofNonOverlapping(self, nums, target):
        prefix_sum = 0
        sum_count = {0: -1}
        max_count = 0
        last_index = -1

        for i, num in enumerate(nums):
            prefix_sum += num
            if (prefix_sum - target) in sum_count:
                if sum_count[prefix_sum - target] < last_index:
                    max_count += 1
                    last_index = i
            sum_count[prefix_sum] = i

        return max_count