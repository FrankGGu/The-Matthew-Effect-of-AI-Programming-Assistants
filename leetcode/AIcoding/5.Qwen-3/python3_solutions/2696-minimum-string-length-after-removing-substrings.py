class Solution:
    def minLengthAfterRemovingSubstrings(self, s: str) -> int:
        stack = []
        for char in s:
            stack.append(char)
            if len(stack) >= 2 and (stack[-2] == 'a' and stack[-1] == 'b' or stack[-2] == 'b' and stack[-1] == 'a'):
                stack.pop()
                stack.pop()
        return len(stack)