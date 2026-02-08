class Solution:
    def longestWPI(self, t: List[int]) -> int:
        score = 0
        first = {}
        max_len = 0
        for i, s in enumerate(t):
            score += 1 if s > 8 else -1
            if score not in first:
                first[score] = i
            if score > 0:
                max_len = i + 1
            else:
                if score - 1 in first:
                    max_len = max(max_len, i - first[score - 1])
        return max_len