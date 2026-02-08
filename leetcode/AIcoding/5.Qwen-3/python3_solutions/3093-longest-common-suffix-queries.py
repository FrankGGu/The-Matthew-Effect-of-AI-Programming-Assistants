class Solution:
    def longestCommonSuffixQueries(self, s: str, queries: List[List[int]]) -> List[int]:
        n = len(s)
        suffix = [0] * n
        for i in range(n - 2, -1, -1):
            if s[i] == s[i + 1]:
                suffix[i] = suffix[i + 1] + 1
            else:
                suffix[i] = 0
        res = []
        for l, r in queries:
            res.append(suffix[l])
        return res