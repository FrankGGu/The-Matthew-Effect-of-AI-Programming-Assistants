class Solution:
    def minCostConnectPoints(self, points):
        n = len(points)
        dist = [[0] * n for _ in range(n)]
        for i in range(n):
            x1, y1 = points[i]
            for j in range(n):
                x2, y2 = points[j]
                dist[i][j] = abs(x1 - x2) + abs(y1 - y2)

        import heapq
        heap = [(0, 0, 0)]
        visited = [False] * n
        min_cost = 0
        count = 0

        while count < n:
            cost, u, v = heapq.heappop(heap)
            if visited[v]:
                continue
            visited[v] = True
            min_cost += cost
            count += 1
            for w in range(n):
                if not visited[w]:
                    heapq.heappush(heap, (dist[v][w], v, w))

        return min_cost