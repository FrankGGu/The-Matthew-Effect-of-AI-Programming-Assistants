class Solution:
    def maximumNumber(self, k: str) -> str:
        def price(n):
            res = 0
            for c in n:
                if c in '2357':
                    res += 1
            return res

        k = int(k)
        max_num = ''
        for i in range(1, 10**18):
            s = str(i)
            if price(s) <= k:
                max_num = s
            else:
                break
        return max_num