from collections import deque
from typing import List

class Solution:
    def shortestAlternatingPath(self, n: int, redEdges: List[List[int]], blueEdges: List[List[int]]) -> List[int]:
        graph = [{} for _ in range(n)]
        for src, dst in redEdges:
            if 'r' not in graph[src]:
                graph[src]['r'] = []
            graph[src]['r'].append(dst)
        for src, dst in blueEdges:
            if 'b' not in graph[src]:
                graph[src]['b'] = []
            graph[src]['b'].append(dst)

        dist = [-1] * n
        queue = deque()
        queue.append((0, 'r', 0))
        queue.append((0, 'b', 0))

        while queue:
            node, color, steps = queue.popleft()
            if dist[node] == -1:
                dist[node] = steps
            else:
                dist[node] = min(dist[node], steps)

            next_color = 'b' if color == 'r' else 'r'
            for neighbor in graph[node].get(next_color, []):
                queue.append((neighbor, next_color, steps + 1))

        return dist