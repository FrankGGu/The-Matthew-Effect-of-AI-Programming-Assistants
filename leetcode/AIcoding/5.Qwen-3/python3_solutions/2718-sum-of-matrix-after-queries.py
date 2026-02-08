class Solution:
    def matrixSumQueries(self, n: int, m: int, queries: List[List[int]]) -> int:
        row_set = set()
        col_set = set()
        res = 0
        for t, i in queries:
            if t == 0:
                if i not in row_set:
                    row_set.add(i)
                    res += sum(m[i])
            else:
                if i not in col_set:
                    col_set.add(i)
                    for j in range(n):
                        res += m[j][i]
        return res