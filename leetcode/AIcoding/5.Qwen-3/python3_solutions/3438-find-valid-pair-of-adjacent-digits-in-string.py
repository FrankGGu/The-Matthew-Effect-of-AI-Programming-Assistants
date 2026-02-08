class Solution:
    def hasValidAdjacentPair(self, s: str) -> bool:
        for i in range(len(s) - 1):
            if abs(int(s[i]) - int(s[i + 1])) == 1:
                return True
        return False