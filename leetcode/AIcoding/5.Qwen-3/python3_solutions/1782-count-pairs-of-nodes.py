class Solution:
    def countPairs(self, n: int, edges: List[List[int]], queries: List[int]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        degree = [0] * (n + 1)
        for i in range(1, n + 1):
            degree[i] = len(graph[i])

        res = []
        for q in queries:
            count = 0
            for i in range(1, n + 1):
                for j in range(i + 1, n + 1):
                    if degree[i] + degree[j] > q:
                        count += 1
            res.append(count)
        return res