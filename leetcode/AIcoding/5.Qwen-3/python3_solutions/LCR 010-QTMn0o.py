class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        count = 0
        prefix_sum = 0
        sum_counts = {0: 1}
        for num in nums:
            prefix_sum += num
            if (prefix_sum - k) in sum_counts:
                count += sum_counts[prefix_sum - k]
            sum_counts[prefix_sum] = sum_counts.get(prefix_sum, 0) + 1
        return count