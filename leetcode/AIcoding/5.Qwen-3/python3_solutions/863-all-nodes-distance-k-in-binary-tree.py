class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, k: int) -> List[int]:
        from collections import deque, defaultdict

        def build_graph(node, parent):
            if not node:
                return
            if parent:
                graph[node].append(parent)
                graph[parent].append(node)
            build_graph(node.left, node)
            build_graph(node.right, node)

        graph = defaultdict(list)
        build_graph(root, None)

        queue = deque()
        queue.append((target, 0))
        visited = set()
        visited.add(target)

        result = []

        while queue:
            node, dist = queue.popleft()
            if dist == k:
                result.append(node.val)
                continue
            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append((neighbor, dist + 1))

        return result