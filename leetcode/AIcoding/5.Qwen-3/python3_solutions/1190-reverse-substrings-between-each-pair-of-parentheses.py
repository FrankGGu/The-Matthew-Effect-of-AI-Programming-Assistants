class Solution:
    def reverseParentheses(self, s: str) -> str:
        stack = []
        for char in s:
            if char == '(':
                stack.append('')
            elif char == ')':
                top = stack.pop()
                if stack:
                    stack[-1] += top[::-1]
                else:
                    stack.append(top[::-1])
            else:
                if stack:
                    stack[-1] += char
                else:
                    stack.append(char)
        return stack[0]