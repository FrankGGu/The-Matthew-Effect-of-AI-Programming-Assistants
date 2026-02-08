class Solution:
    def findChampion(self, n: int, edges: List[List[int]]) -> int:
        in_degree = [0] * n
        for u, v in edges:
            in_degree[v] += 1
        candidates = [i for i in range(n) if in_degree[i] == 0]
        if len(candidates) != 1:
            return -1
        return candidates[0]