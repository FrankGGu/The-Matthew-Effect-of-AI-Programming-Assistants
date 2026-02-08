class Solution:
    def magicalString(self, n: int) -> int:
        if n == 0:
            return 0
        if n <= 4:
            return 1

        res = [1, 1, 2, 1]
        i = 3
        while len(res) < n:
            next_val = 1 if res[i] == 2 else 2
            count = res[i]
            for _ in range(count):
                res.append(next_val)
            i += 1

        return res[n-1]