class Solution:
    def modifiedGraphEdges(self, n: int, edges: List[List[int]], source: int, destination: int, target: int) -> List[List[int]]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start, new_edges):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, u = heapq.heappop(heap)
                if d > dist[u]:
                    continue
                for v, w in graph[u]:
                    if (u, v) in new_edges or (v, u) in new_edges:
                        w = new_edges[(u, v)] if (u, v) in new_edges else new_edges[(v, u)]
                    if dist[v] > d + w:
                        dist[v] = d + w
                        heapq.heappush(heap, (dist[v], v))
            return dist[destination]

        new_edges = {}
        for u, v, w in edges:
            if w != -1:
                new_edges[(u, v)] = w
                new_edges[(v, u)] = w

        min_dist = dijkstra(source, new_edges)
        if min_dist < target:
            return []

        for i in range(len(edges)):
            u, v, w = edges[i]
            if w == -1:
                edges[i][2] = 1
                new_edges[(u, v)] = 1
                new_edges[(v, u)] = 1
                dist = dijkstra(source, new_edges)
                if dist <= target:
                    edges[i][2] = target - (dijkstra(source, new_edges) - dist)
                    break

        return edges