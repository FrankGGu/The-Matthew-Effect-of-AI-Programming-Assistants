from collections import deque, defaultdict
from typing import List

class Solution:
    def distanceHouses(self, n: int, queries: List[List[int]]) -> List[int]:
        graph = defaultdict(list)
        for a, b in zip(range(1, n), range(2, n + 1)):
            graph[a].append(b)
            graph[b].append(a)

        result = []
        for s, d in queries:
            visited = set()
            queue = deque([(s, 0)])
            while queue:
                node, dist = queue.popleft()
                if node in visited:
                    continue
                visited.add(node)
                if dist == d:
                    result.append(node)
                    break
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        queue.append((neighbor, dist + 1))
        return result