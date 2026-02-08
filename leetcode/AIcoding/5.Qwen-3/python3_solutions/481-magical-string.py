class Solution:
    def magicalString(self, n: int) -> int:
        if n == 0:
            return 0
        if n <= 3:
            return 1
        res = [1, 1, 2]
        i = 2
        while len(res) < n:
            next_val = 1 if res[-1] == 2 else 2
            count = res[i]
            for _ in range(count):
                res.append(next_val)
            i += 1
        return sum(1 for x in res[:n] if x == 1)