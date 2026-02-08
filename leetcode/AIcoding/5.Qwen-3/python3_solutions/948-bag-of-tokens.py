class Solution:
    def bagOfTokens(self, tokens: List[int], power: int) -> int:
        tokens.sort()
        left = 0
        right = len(tokens) - 1
        max_score = 0
        current_score = 0

        while left <= right:
            if tokens[left] <= power:
                power -= tokens[left]
                left += 1
                current_score += 1
                max_score = max(max_score, current_score)
            elif current_score > 0:
                power += tokens[right]
                right -= 1
                current_score -= 1
            else:
                break

        return max_score