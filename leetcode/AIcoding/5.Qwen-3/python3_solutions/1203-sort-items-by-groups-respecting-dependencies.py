from collections import defaultdict, deque
from typing import List

class Solution:
    def sortItems(self, n: int, m: int, group: List[int], beforeItems: List[List[int]]) -> List[int]:
        graph = defaultdict(list)
        in_degree = [0] * n
        group_graph = defaultdict(list)
        group_in_degree = [0] * m

        for i in range(n):
            if group[i] == -1:
                group[i] = m
                m += 1

        for i in range(n):
            for j in beforeItems[i]:
                graph[j].append(i)
                in_degree[i] += 1
                if group[j] != group[i]:
                    group_graph[group[j]].append(group[i])
                    group_in_degree[group[i]] += 1

        def topological_sort(nodes, graph, in_degree):
            queue = deque()
            for node in nodes:
                if in_degree[node] == 0:
                    queue.append(node)
            result = []
            while queue:
                u = queue.popleft()
                result.append(u)
                for v in graph[u]:
                    in_degree[v] -= 1
                    if in_degree[v] == 0:
                        queue.append(v)
            return result if len(result) == len(nodes) else []

        group_nodes = set(group)
        group_order = topological_sort(group_nodes, group_graph, group_in_degree)
        if len(group_order) != len(group_nodes):
            return []

        item_order = topological_sort(range(n), graph, in_degree)
        if len(item_order) != n:
            return []

        group_to_items = defaultdict(list)
        for item in item_order:
            group_to_items[group[item]].append(item)

        result = []
        for g in group_order:
            result.extend(group_to_items[g])

        return result