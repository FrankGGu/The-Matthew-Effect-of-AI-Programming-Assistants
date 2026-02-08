class Solution:
    def maxDepthAfterSplit(self, command: str) -> int:
        depth = 0
        result = 0
        for c in command:
            if c == '(':
                depth += 1
                result = max(result, depth)
            else:
                depth -= 1
        return result