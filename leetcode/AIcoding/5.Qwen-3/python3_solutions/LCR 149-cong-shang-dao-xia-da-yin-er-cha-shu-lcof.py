class Solution:
    def decorateRecord(self, root: TreeNode) -> List[str]:
        if not root:
            return []

        result = []
        queue = [root]

        while queue:
            node = queue.pop(0)
            result.append(str(node.val))
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

        return result