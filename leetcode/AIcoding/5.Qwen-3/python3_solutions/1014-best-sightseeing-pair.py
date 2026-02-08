class Solution:
    def maxScoreSightseeing(self, values: List[int]) -> int:
        max_score = 0
        prev = values[0]
        for i in range(1, len(values)):
            current_score = prev + values[i] - 1
            max_score = max(max_score, current_score)
            prev = max(prev, values[i])
        return max_score