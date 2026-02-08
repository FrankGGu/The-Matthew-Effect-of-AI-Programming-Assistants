class Solution:
    def maximumSubarraySum(self, nums: List[int]) -> int:
        n = len(nums)
        max_sum = float('-inf')
        left = 0
        current_sum = 0
        count = defaultdict(int)

        for right in range(n):
            current_sum += nums[right]
            count[nums[right]] += 1

            while count[nums[right]] > 1:
                current_sum -= nums[left]
                count[nums[left]] -= 1
                left += 1

            max_sum = max(max_sum, current_sum)

        return max_sum