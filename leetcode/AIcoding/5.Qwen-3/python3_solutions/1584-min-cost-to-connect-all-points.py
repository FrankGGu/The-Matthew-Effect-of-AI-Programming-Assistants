class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        import heapq

        n = len(points)
        visited = [False] * n
        min_heap = [(0, 0)]
        total_cost = 0

        while min_heap:
            cost, i = heapq.heappop(min_heap)
            if visited[i]:
                continue
            visited[i] = True
            total_cost += cost
            for j in range(n):
                if not visited[j]:
                    distance = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                    heapq.heappush(min_heap, (distance, j))

        return total_cost