class Solution:
    def pathSum(self, root: TreeNode, targetSum: int) -> List[List[int]]:
        result = []

        def dfs(node, path, current_sum):
            if not node:
                return
            current_sum += node.val
            path.append(node.val)
            if not node.left and not node.right and current_sum == targetSum:
                result.append(path[:])
            dfs(node.left, path, current_sum)
            dfs(node.right, path, current_sum)
            path.pop()

        dfs(root, [], 0)
        return result