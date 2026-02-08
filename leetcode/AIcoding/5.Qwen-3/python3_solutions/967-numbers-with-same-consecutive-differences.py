class Solution:
    def numDupDigitsInRange(self, n: int) -> int:
        def count(x):
            s = str(x)
            n = len(s)
            res = 0
            for i in range(1, n):
                res += 9 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 // (9 - i + 1)
            used = [False] * 10
            for i in range(n):
                d = int(s[i])
                for j in range(0 if i > 0 else 1, d):
                    if not used[j]:
                        res += 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 // (9 - i)
                if used[d]:
                    break
                used[d] = True
            return res

        return count(n)