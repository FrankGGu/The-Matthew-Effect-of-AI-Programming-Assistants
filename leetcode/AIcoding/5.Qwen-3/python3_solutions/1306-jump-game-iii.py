class Solution:
    def canReach(self, s: str, idx: int) -> bool:
        if idx < 0 or idx >= len(s) or s[idx] == '1':
            return False
        s = s[:idx] + '1' + s[idx+1:]
        return self.canReach(s, idx + 1) or self.canReach(s, idx - 1)