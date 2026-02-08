class Solution:
    def eventualSafeStates(self, graph: List[List[int]]) -> List[int]:
        from collections import deque

        n = len(graph)
        color = [0] * n

        def is_safe(node):
            if color[node] != 0:
                return color[node] == 2
            color[node] = 1
            for neighbor in graph[node]:
                if not is_safe(neighbor):
                    return False
            color[node] = 2
            return True

        result = []
        for i in range(n):
            if is_safe(i):
                result.append(i)
        return result