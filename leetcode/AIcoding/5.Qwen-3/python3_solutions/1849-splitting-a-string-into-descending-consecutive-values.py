class Solution:
    def splitString(self, s: str) -> bool:
        def dfs(index, prev, count):
            if index == len(s):
                return count >= 2
            for i in range(index + 1, len(s) + 1):
                curr = int(s[index:i])
                if prev == -1 or curr == prev - 1:
                    if dfs(i, curr, count + 1):
                        return True
            return False

        return dfs(0, -1, 0)