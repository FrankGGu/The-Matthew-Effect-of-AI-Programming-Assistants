import heapq

class Solution:
    def reachableNodes(self, edges: List[List[int]], M: int, N: int) -> int:
        graph = [[] for _ in range(N)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        max_heap = [(-M, 0)]
        visited = [False] * N
        result = 0

        while max_heap:
            remaining, node = heapq.heappop(max_heap)
            remaining = -remaining

            if visited[node]:
                continue

            visited[node] = True
            result += 1

            for neighbor, weight in graph[node]:
                if not visited[neighbor] and remaining > 0:
                    new_remaining = remaining - weight
                    if new_remaining >= 0:
                        heapq.heappush(max_heap, (-new_remaining, neighbor))
                    else:
                        result += abs(new_remaining)

        return result