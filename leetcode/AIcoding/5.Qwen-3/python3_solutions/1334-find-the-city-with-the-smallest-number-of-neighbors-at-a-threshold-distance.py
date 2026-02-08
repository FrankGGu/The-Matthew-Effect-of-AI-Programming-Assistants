class Solution:
    def findTheCity(self, n: int, edges: List[List[int]], distanceThreshold: int) -> int:
        import heapq

        graph = [[] for _ in range(n)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, u = heapq.heappop(heap)
                if d > dist[u]:
                    continue
                for v, w in graph[u]:
                    if dist[v] > d + w:
                        dist[v] = d + w
                        heapq.heappush(heap, (dist[v], v))
            return dist

        min_cities = float('inf')
        result_city = -1

        for i in range(n):
            dist = dijkstra(i)
            count = sum(1 for d in dist if d <= distanceThreshold)
            if count <= min_cities:
                min_cities = count
                result_city = i

        return result_city