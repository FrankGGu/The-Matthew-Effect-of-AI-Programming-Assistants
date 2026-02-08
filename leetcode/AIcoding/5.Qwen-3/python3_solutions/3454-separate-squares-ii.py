class Solution:
    def splitIntoFibonacci(self, S: str) -> List[int]:
        def backtrack(start, path):
            if start == len(S):
                return path[:] if len(path) >= 3 else None
            for i in range(start + 1, min(len(S), start + 10) + 1):
                num = int(S[start:i])
                if num > 2**31 - 1:
                    break
                if len(path) < 2 or num == path[-1] + path[-2]:
                    path.append(num)
                    result = backtrack(i, path)
                    if result:
                        return result
                    path.pop()
            return None

        return backtrack(0, [])