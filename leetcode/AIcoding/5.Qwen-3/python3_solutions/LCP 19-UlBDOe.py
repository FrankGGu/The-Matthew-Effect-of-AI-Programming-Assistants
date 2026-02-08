class Solution:
    def collectTheCoins(self, s: str) -> int:
        n = len(s)
        left = 0
        right = n - 1
        while left <= right and s[left] == '0':
            left += 1
        while left <= right and s[right] == '0':
            right -= 1
        if left > right:
            return 0
        s = s[left:right + 1]
        n = len(s)
        for i in range(n):
            if s[i] == '1':
                break
        else:
            return 0
        for i in range(n - 1, -1, -1):
            if s[i] == '1':
                break
        else:
            return 0
        s = s[i - 1: i + 2]
        return max(0, len(s) - 2)