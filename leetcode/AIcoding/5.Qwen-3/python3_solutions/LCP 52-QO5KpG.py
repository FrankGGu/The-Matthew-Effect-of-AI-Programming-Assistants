class Solution:
    def __init__(self):
        self.color_count = 0

    def dfs(self, node, target, color):
        if not node:
            return
        if node.val == target:
            self.color_count += 1
            node.val = color
        self.dfs(node.left, target, color)
        self.dfs(node.right, target, color)

    def deleteNode(self, root: TreeNode, key: int) -> TreeNode:
        if not root:
            return None
        if root.val == key:
            if not root.left and not root.right:
                return None
            elif not root.left:
                return root.right
            elif not root.right:
                return root.left
            else:
                temp = root.right
                while temp.left:
                    temp = temp.left
                root.val = temp.val
                root.right = self.deleteNode(root.right, temp.val)
        elif key < root.val:
            root.left = self.deleteNode(root.left, key)
        else:
            root.right = self.deleteNode(root.right, key)
        return root

    def paintTree(self, root: TreeNode, target: int, color: int) -> TreeNode:
        self.dfs(root, target, color)
        return root