class Solution:
    def maximumSum(self, nums: List[int]) -> int:
        from collections import defaultdict

        max_sum = -1
        digit_sum = defaultdict(list)

        for num in nums:
            s = sum(int(d) for d in str(num))
            digit_sum[s].append(num)

        for key in digit_sum:
            if len(digit_sum[key]) >= 2:
                sorted_nums = sorted(digit_sum[key], reverse=True)
                current_sum = sorted_nums[0] + sorted_nums[1]
                if current_sum > max_sum:
                    max_sum = current_sum

        return max_sum