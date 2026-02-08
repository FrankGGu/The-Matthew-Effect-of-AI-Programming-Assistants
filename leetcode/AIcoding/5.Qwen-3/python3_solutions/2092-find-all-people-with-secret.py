class Solution:
    def findAllPeople(self, n: int, meetings: List[List[int]], firstPerson: int) -> List[int]:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in meetings:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()
        visited.add(firstPerson)

        queue = deque([firstPerson])

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append(neighbor)

        return list(visited)