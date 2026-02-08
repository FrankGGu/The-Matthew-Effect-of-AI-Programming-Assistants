class Solution:
    def spellBlast(self, skills: str) -> int:
        stack = []
        for ch in skills:
            if stack and stack[-1] == ch:
                stack.pop()
            else:
                stack.append(ch)
        return len(stack)