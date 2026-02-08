class Solution:
    def maxConfusion(self, answerKey: str, k: int) -> int:
        def maxConsecutiveChar(s, target, k):
            left = 0
            max_len = 0
            for right in range(len(s)):
                if s[right] != target:
                    k -= 1
                while k < 0:
                    if s[left] != target:
                        k += 1
                    left += 1
                max_len = max(max_len, right - left + 1)
            return max_len

        return max(maxConsecutiveChar(answerKey, 'T', k), maxConsecutiveChar(answerKey, 'F', k))