class Solution:
    def numSquarefulArrays(self, A: List[int]) -> int:
        from collections import Counter
        import math

        def is_square(n):
            return n >= 0 and int(math.isqrt(n)) ** 2 == n

        def backtrack(path, used):
            if len(path) == len(A):
                return 1
            count = 0
            for i in range(len(A)):
                if not used[i]:
                    if path and not is_square(path[-1] + A[i]):
                        continue
                    used[i] = True
                    count += backtrack(path + [A[i]], used)
                    used[i] = False
            return count

        A.sort()
        counter = Counter(A)
        used = [False] * len(A)
        return backtrack([], used)