class Solution:
    def binaryTreePaths(self, root: TreeNode) -> List[str]:
        result = []

        def dfs(node, path):
            if not node:
                return
            if not node.left and not node.right:
                result.append(path + str(node.val))
                return
            dfs(node.left, path + str(node.val) + "->")
            dfs(node.right, path + str(node.val) + "->")

        dfs(root, "")
        return result