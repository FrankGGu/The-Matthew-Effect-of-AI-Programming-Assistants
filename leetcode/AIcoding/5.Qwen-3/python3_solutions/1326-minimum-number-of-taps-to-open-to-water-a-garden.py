class Solution:
    def minTaps(self, n: int) -> int:
        import math
        from collections import deque

        taps = [0] * (n + 1)
        for i in range(n + 1):
            start = max(0, i - taps[i])
            end = min(n, i + taps[i])
            taps[i] = end

        taps = [0] * (n + 1)
        for i in range(n + 1):
            start = max(0, i - taps[i])
            end = min(n, i + taps[i])
            taps[i] = end

        res = 0
        cur_end = 0
        next_end = 0
        i = 0
        while i <= n:
            if i > cur_end:
                return -1
            while i <= n and i <= cur_end:
                next_end = max(next_end, taps[i])
                i += 1
            res += 1
            cur_end = next_end
            if cur_end >= n:
                return res
        return res