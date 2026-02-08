class Solution:
    def beautifulArrangement(self, n: int) -> List[int]:
        def backtrack(path, used):
            if len(path) == n:
                return path[:]
            for i in range(1, n + 1):
                if not used[i]:
                    if (len(path) + 1) % i == 0 or i % (len(path) + 1) == 0:
                        used[i] = True
                        path.append(i)
                        result = backtrack(path, used)
                        if result:
                            return result
                        path.pop()
                        used[i] = False
            return None

        return backtrack([], [False] * (n + 1))