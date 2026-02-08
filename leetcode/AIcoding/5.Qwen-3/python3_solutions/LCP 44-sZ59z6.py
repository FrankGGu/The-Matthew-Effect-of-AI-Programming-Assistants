class Solution:
    def firework(self, n: int, m: int, k: int) -> int:
        from collections import deque
        import heapq

        adj = [[] for _ in range(n)]
        for _ in range(m):
            u, v = map(int, input().split())
            adj[u].append(v)
            adj[v].append(u)

        dist = [-1] * n
        q = deque()
        for _ in range(k):
            s = int(input())
            dist[s] = 0
            q.append(s)

        while q:
            u = q.popleft()
            for v in adj[u]:
                if dist[v] == -1:
                    dist[v] = dist[u] + 1
                    q.append(v)

        return max(dist)