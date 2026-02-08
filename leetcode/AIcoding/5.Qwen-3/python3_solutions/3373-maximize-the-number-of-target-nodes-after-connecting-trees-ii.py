class Solution:
    def connectTrees(self, n: int, edges1: List[List[int]], edges2: List[List[int]]) -> int:
        from collections import defaultdict, deque

        def build_tree(edges):
            tree = defaultdict(list)
            for u, v in edges:
                tree[u].append(v)
                tree[v].append(u)
            return tree

        tree1 = build_tree(edges1)
        tree2 = build_tree(edges2)

        def bfs(start, tree):
            visited = set()
            q = deque()
            q.append(start)
            visited.add(start)
            while q:
                node = q.popleft()
                for neighbor in tree[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append(neighbor)
            return visited

        def get_all_nodes(tree):
            nodes = set()
            for node in tree:
                nodes.add(node)
            return nodes

        nodes1 = get_all_nodes(tree1)
        nodes2 = get_all_nodes(tree2)

        common_nodes = nodes1 & nodes2

        if not common_nodes:
            return 0

        max_count = 0

        for node in common_nodes:
            visited1 = bfs(node, tree1)
            visited2 = bfs(node, tree2)
            count = len(visited1 & visited2)
            max_count = max(max_count, count)

        return max_count