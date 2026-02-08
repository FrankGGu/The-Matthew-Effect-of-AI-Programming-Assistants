class Solution:
    def countOfAtoms(self, formula: str) -> str:
        from collections import defaultdict
        import re

        def parse_formula(formula):
            stack = [defaultdict(int)]
            i = 0
            n = len(formula)
            while i < n:
                if formula[i] == '(':
                    stack.append(defaultdict(int))
                    i += 1
                elif formula[i] == ')':
                    i += 1
                    num = ''
                    while i < n and formula[i].isdigit():
                        num += formula[i]
                        i += 1
                    if num:
                        num = int(num)
                    else:
                        num = 1
                    top = stack.pop()
                    for key, val in top.items():
                        stack[-1][key] += val * num
                else:
                    element = ''
                    while i < n and formula[i].isalpha() and formula[i].isupper():
                        element += formula[i]
                        i += 1
                    if i < n and formula[i].islower():
                        element += formula[i]
                        i += 1
                    num = ''
                    while i < n and formula[i].isdigit():
                        num += formula[i]
                        i += 1
                    if num:
                        num = int(num)
                    else:
                        num = 1
                    stack[-1][element] += num
            return stack[0]

        counts = parse_formula(formula)
        result = []
        for key in sorted(counts.keys()):
            result.append(key)
            if counts[key] > 1:
                result.append(str(counts[key]))
        return ''.join(result)