class Solution:
    def scoreOfStudents(self, expression: str) -> int:
        from functools import lru_cache

        def parse(expr):
            stack = []
            num = 0
            for c in expr:
                if c.isdigit():
                    num = num * 10 + int(c)
                else:
                    if num:
                        stack.append(num)
                        num = 0
                    stack.append(c)
            if num:
                stack.append(num)
            return stack

        def evaluate(expr):
            stack = []
            num = 0
            for c in expr:
                if c == '(':
                    stack.append(num)
                    stack.append('(')
                    num = 0
                elif c == ')':
                    while stack[-1] != '(':
                        num = apply(stack.pop(), num, stack.pop())
                    stack.pop()
                    stack.append(num)
                    num = 0
                elif c in '+*':
                    while stack and stack[-1] != '(' and (c == '*' or stack[-1] in '+*'):
                        num = apply(stack.pop(), num, stack.pop())
                    stack.append(c)
                else:
                    num = num * 10 + int(c)
            while stack:
                num = apply(stack.pop(), num, stack.pop())
            return num

        def apply(op, b, a):
            if op == '+':
                return a + b
            elif op == '*':
                return a * b
            else:
                return 0

        def dfs(expr, i, j):
            if i == j:
                return {expr[i]}
            res = set()
            for k in range(i + 1, j, 2):
                left = dfs(expr, i, k - 1)
                right = dfs(expr, k + 1, j)
                for a in left:
                    for b in right:
                        if expr[k] == '+':
                            val = a + b
                        else:
                            val = a * b
                        if val <= 1000:
                            res.add(val)
            return res

        parsed = parse(expression)
        correct = evaluate(parsed)
        if correct > 1000:
            return 0
        students = dfs(parsed, 0, len(parsed) - 1)
        return sum(1 for x in students if x == correct)