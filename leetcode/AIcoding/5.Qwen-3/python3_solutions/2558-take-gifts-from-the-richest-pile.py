class Solution:
    def bagOfTokens(self, nums: List[int], power: int) -> int:
        nums.sort()
        left = 0
        right = len(nums) - 1
        max_score = 0
        current_score = 0

        while left <= right:
            if nums[left] <= power:
                power -= nums[left]
                current_score += 1
                left += 1
                max_score = max(max_score, current_score)
            elif current_score > 0:
                power += nums[right]
                current_score -= 1
                right -= 1
            else:
                break

        return max_score