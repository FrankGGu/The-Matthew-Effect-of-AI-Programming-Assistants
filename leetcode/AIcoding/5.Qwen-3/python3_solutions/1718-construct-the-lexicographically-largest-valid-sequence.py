class Solution:
    def constructLargeNum(self, n: int) -> str:
        def backtrack(path, used):
            if len(path) == n:
                return path
            for i in range(n, 0, -1):
                if not used[i]:
                    if not path or (i + int(path[-1])) % 2 == 1:
                        used[i] = True
                        res = backtrack(path + str(i), used)
                        if res:
                            return res
                        used[i] = False
            return ""

        return backtrack("", [False] * (n + 1))