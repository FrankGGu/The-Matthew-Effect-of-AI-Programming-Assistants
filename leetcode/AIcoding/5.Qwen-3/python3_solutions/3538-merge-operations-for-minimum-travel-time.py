class Solution:
    def minTravelTime(self, n: int, roads: List[List[int]], queries: List[int]) -> List[int]:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, t in roads:
            graph[u].append((v, t))
            graph[v].append((u, t))

        def dijkstra(start):
            dist = [float('inf')] * (n + 1)
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, u = heapq.heappop(heap)
                if d > dist[u]:
                    continue
                for v, t in graph[u]:
                    if dist[v] > d + t:
                        dist[v] = d + t
                        heapq.heappush(heap, (dist[v], v))
            return dist

        dist = dijkstra(1)
        result = []
        for q in queries:
            result.append(dist[q])
        return result