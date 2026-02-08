class Solution:
    def allPathsSourceTarget(self, node: TreeNode) -> List[List[int]]:
        result = []
        def dfs(node, path):
            if not node:
                return
            path.append(node.val)
            if not node.left and not node.right:
                result.append(path[:])
            dfs(node.left, path)
            dfs(node.right, path)
            path.pop()
        dfs(node, [])
        return result