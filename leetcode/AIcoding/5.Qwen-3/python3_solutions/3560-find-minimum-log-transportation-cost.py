class Solution:
    def minCost(self, n: int, roads: List[List[int]], trips: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v, cost in roads:
            graph[u].append((v, cost))
            graph[v].append((u, cost))

        parent = {}
        depth = {}

        def bfs(start):
            queue = deque([(start, -1, 0)])
            while queue:
                node, p, d = queue.popleft()
                parent[node] = p
                depth[node] = d
                for neighbor, _ in graph[node]:
                    if neighbor != p:
                        queue.append((neighbor, node, d + 1))

        bfs(0)

        def lca(u, v):
            while depth[u] > depth[v]:
                u = parent[u]
            while depth[v] > depth[u]:
                v = parent[v]
            while u != v:
                u = parent[u]
                v = parent[v]
            return u

        edge_cost = defaultdict(int)

        def dfs(node, prev):
            for neighbor, cost in graph[node]:
                if neighbor != prev:
                    edge_cost[(node, neighbor)] += cost
                    dfs(neighbor, node)

        for u, v in trips:
            ancestor = lca(u, v)
            while u != ancestor:
                edge_cost[(u, parent[u])] += 1
                u = parent[u]
            while v != ancestor:
                edge_cost[(v, parent[v])] += 1
                v = parent[v]

        total = 0
        for (u, v), count in edge_cost.items():
            total += count * (u if u < v else v)
        return total