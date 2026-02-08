from typing import List
import collections

class Solution:
    def maxPathQuality(self, scores: List[int], edges: List[List[int]]) -> int:
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        self.result = 0

        def dfs(node, visited, current_score):
            if node in visited:
                return
            visited.add(node)
            current_score += scores[node]
            if len(visited) == len(scores):
                self.result = max(self.result, current_score)
            for neighbor in graph[node]:
                dfs(neighbor, visited.copy(), current_score)

        for start in range(len(scores)):
            dfs(start, set(), 0)

        return self.result