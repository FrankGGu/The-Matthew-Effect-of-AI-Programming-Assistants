class Solution:
    def maxTotalFruits(self, position: List[int], amount: List[int], k: int) -> int:
        from collections import defaultdict

        pos = sorted(zip(position, amount))
        n = len(pos)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + pos[i][1]

        def get_sum(l, r):
            return prefix[r + 1] - prefix[l]

        res = 0
        for i in range(n):
            l = i
            r = i
            curr = 0
            while l >= 0 and r < n:
                if pos[r][0] - pos[l][0] > k:
                    break
                curr += pos[r][1]
                res = max(res, curr)
                if pos[r + 1][0] - pos[l][0] <= k:
                    r += 1
                else:
                    l -= 1
        return res