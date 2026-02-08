class Solution:
    def maxLen(self, nums: List[int]) -> int:
        max_len = 0
        positive = 0
        negative = 0
        for num in nums:
            if num == 0:
                positive = 0
                negative = 0
            elif num > 0:
                positive += 1
                negative += 1
            else:
                positive, negative = negative + 1, positive + 1
            if positive > max_len:
                max_len = positive
        return max_len