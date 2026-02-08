class Solution:
    def braceExpansionII(self, expression: str) -> List[str]:
        from itertools import product

        def expand(expr):
            if not expr:
                return ['']
            if expr[0] != '{':
                res = []
                for s in expand(expr[1:]):
                    res.append(expr[0] + s)
                return res
            count = 0
            for i, c in enumerate(expr):
                if c == '{':
                    count += 1
                elif c == '}':
                    count -= 1
                    if count == 0:
                        break
            parts = []
            for part in expr[1:i].split(','):
                parts.append(expand(part))
            rest = expand(expr[i+1:])
            result = []
            for p in product(*parts):
                result.extend([ ''.join(p) + r for r in rest ])
            return result

        return sorted(expand(expression))