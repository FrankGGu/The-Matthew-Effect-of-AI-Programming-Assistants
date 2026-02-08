class Solution:
    def smallestSubsequence(self, s: str, k: int, letter: str, min_occurrences: int) -> str:
        from collections import Counter

        count = Counter(s)
        stack = []
        n = len(s)
        remaining = n - k

        for i, c in enumerate(s):
            while stack and stack[-1] > c and remaining > 0:
                if stack[-1] == letter and count[stack[-1]] - (i < n and s[i:] or 0).count(stack[-1]) < min_occurrences:
                    break
                stack.pop()
                remaining -= 1
            stack.append(c)
            count[c] -= 1

        return ''.join(stack[:k])