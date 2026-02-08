class Solution:
    def minimizeResult(self, expression: str) -> str:
        left, right = expression.split('+')
        min_val = float('inf')
        result = ""
        for i in range(len(left)):
            for j in range(1, len(right) + 1):
                l = int(left[:i]) if i > 0 else 1
                r = int(right[j:]) if j < len(right) else 1
                val = l * (int(left[i:]) + int(right[:j])) * r
                if val < min_val:
                    min_val = val
                    result = f"({left[i:]}+{right[:j]})"
        return result