class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result = []
        self.inorder(root, result)
        return result

    def inorder(self, root, result):
        if root is None:
            return
        self.inorder(root.left, result)
        result.append(root.val)
        self.inorder(root.right, result)