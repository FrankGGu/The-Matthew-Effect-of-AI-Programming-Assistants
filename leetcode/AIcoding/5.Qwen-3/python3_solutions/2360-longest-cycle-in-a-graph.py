class Solution:
    def longestCycle(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)

        visited = [False] * n
        max_cycle = -1

        for i in range(n):
            if not visited[i]:
                queue = deque()
                queue.append(i)
                visited[i] = True
                parent = {i: -1}
                while queue:
                    node = queue.popleft()
                    for neighbor in graph[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            parent[neighbor] = node
                            queue.append(neighbor)
                        else:
                            if neighbor in parent and parent[node] != neighbor:
                                cycle_length = 1
                                current = node
                                while current != neighbor:
                                    current = parent[current]
                                    cycle_length += 1
                                max_cycle = max(max_cycle, cycle_length)

        return max_cycle