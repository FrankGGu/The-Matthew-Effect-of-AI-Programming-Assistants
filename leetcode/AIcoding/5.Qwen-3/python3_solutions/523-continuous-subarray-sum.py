class Solution:
    def continuousSubarraySum(self, nums: List[int]) -> List[int]:
        prefix_sum = 0
        sum_index = {0: -1}
        max_length = 0
        start = 0
        end = 0
        for i in range(len(nums)):
            prefix_sum += nums[i]
            if prefix_sum in sum_index:
                if i - sum_index[prefix_sum] > max_length:
                    max_length = i - sum_index[prefix_sum]
                    start = sum_index[prefix_sum] + 1
                    end = i
            else:
                sum_index[prefix_sum] = i
        return [start, end]