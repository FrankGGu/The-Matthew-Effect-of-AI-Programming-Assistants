class Solution:
    def findMinMaxEdge(self, n: int, edges: List[List[int]], k: int) -> int:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        min_heap = [(0, 1)]
        visited = [False] * (n + 1)
        max_edge = 0

        while min_heap and k > 0:
            current_weight, node = heapq.heappop(min_heap)
            if visited[node]:
                continue
            visited[node] = True
            max_edge = max(max_edge, current_weight)
            k -= 1
            for neighbor, weight in graph[node]:
                if not visited[neighbor]:
                    heapq.heappush(min_heap, (weight, neighbor))

        return max_edge