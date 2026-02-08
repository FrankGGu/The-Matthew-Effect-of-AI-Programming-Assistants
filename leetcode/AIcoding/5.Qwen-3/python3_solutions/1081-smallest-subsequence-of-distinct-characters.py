class Solution:
    def smallestSubsequence(self, s: str) -> str:
        last_occurrence = {}
        for i, char in enumerate(s):
            last_occurrence[char] = i

        stack = []
        seen = set()

        for i, char in enumerate(s):
            if char in seen:
                continue
            while stack and char < stack[-1] and last_occurrence[stack[-1]] > i:
                removed = stack.pop()
                seen.remove(removed)
            stack.append(char)
            seen.add(char)

        return ''.join(stack)