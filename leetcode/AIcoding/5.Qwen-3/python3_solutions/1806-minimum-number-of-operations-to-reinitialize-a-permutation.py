class Solution:
    def reinitializeThePermutation(self, n: int) -> int:
        res = 0
        pos = 0
        while True:
            if pos == 0:
                return res
            if pos < n // 2:
                pos *= 2
            else:
                pos = 2 * (pos - n // 2) + 1
            res += 1