class Solution:
    def minCost(self, expression: str) -> int:
        def parse(expr):
            stack = []
            i = 0
            while i < len(expr):
                if expr[i] == '(':
                    stack.append(expr[i])
                    i += 1
                elif expr[i] == ')':
                    temp = []
                    while stack and stack[-1] != '(':
                        temp.append(stack.pop())
                    stack.pop()
                    if temp:
                        stack.append(''.join(temp[::-1]))
                    i += 1
                elif expr[i] in '01':
                    stack.append(expr[i])
                    i += 1
                else:
                    stack.append(expr[i])
                    i += 1
            return ''.join(stack)

        expr = parse(expression)

        def evaluate(expr, cost):
            if expr == '0':
                return (0, cost)
            if expr == '1':
                return (1, cost)
            if expr[0] == '!':
                val, c = evaluate(expr[1:], cost + 1)
                return (1 - val, c)
            else:
                op = expr[1]
                left_val, left_cost = evaluate(expr[0], cost)
                right_val, right_cost = evaluate(expr[2], cost)
                new_cost = left_cost + right_cost
                if op == '&':
                    return (left_val & right_val, new_cost)
                else:
                    return (left_val | right_val, new_cost)

        def build(expr):
            if len(expr) == 1:
                return expr
            if expr[0] == '!':
                return '!' + build(expr[1:])
            else:
                return build(expr[0]) + expr[1] + build(expr[2])

        def dfs(expr):
            if expr == '0' or expr == '1':
                return (int(expr), 0)
            if expr[0] == '!':
                val, cost = dfs(expr[1:])
                return (1 - val, cost + 1)
            else:
                left_val, left_cost = dfs(expr[0])
                right_val, right_cost = dfs(expr[2])
                new_cost = left_cost + right_cost
                if expr[1] == '&':
                    return (left_val & right_val, new_cost)
                else:
                    return (left_val | right_val, new_cost)

        def get_all(expr):
            if expr == '0' or expr == '1':
                return [expr]
            if expr[0] == '!':
                return ['!' + s for s in get_all(expr[1:])]
            else:
                left = get_all(expr[0])
                right = get_all(expr[2])
                res = []
                for l in left:
                    for r in right:
                        res.append(l + expr[1] + r)
                return res

        def solve(expr):
            if expr == '0':
                return 0
            if expr == '1':
                return 0
            if expr[0] == '!':
                return solve(expr[1:]) + 1
            else:
                left = solve(expr[0])
                right = solve(expr[2])
                return left + right

        from functools import lru_cache

        @lru_cache(None)
        def dp(expr):
            if expr == '0':
                return 0
            if expr == '1':
                return 0
            if expr[0] == '!':
                return dp(expr[1:]) + 1
            else:
                left = dp(expr[0])
                right = dp(expr[2])
                return left + right

        return dp(expr)