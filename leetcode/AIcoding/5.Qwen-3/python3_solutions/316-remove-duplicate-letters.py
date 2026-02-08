class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        stack = []
        seen = set()
        last_occurrence = {char: idx for idx, char in enumerate(s)}

        for idx, char in enumerate(s):
            if char in seen:
                continue
            while stack and char < stack[-1] and last_occurrence[stack[-1]] > idx:
                removed = stack.pop()
                seen.remove(removed)
            stack.append(char)
            seen.add(char)

        return ''.join(stack)