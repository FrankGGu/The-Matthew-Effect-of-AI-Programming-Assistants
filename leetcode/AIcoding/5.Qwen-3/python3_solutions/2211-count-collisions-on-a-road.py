class Solution:
    def countCollisions(self, s: str) -> int:
        stack = []
        for c in s:
            if not stack:
                stack.append(c)
            else:
                if stack[-1] == 'S' or c == 'S':
                    stack.append(c)
                elif stack[-1] == 'R' and c == 'L':
                    stack.append('S')
                else:
                    stack.append(c)
        res = 0
        for i in range(1, len(stack)):
            if stack[i] == 'S' or (stack[i] == 'L' and stack[i-1] == 'S'):
                res += 1
        return res