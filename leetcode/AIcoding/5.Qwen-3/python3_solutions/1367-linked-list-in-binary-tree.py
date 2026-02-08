class Solution:
    def isSubPath(self, head: ListNode, root: TreeNode) -> bool:
        def dfs(node, head):
            if not head:
                return True
            if not node:
                return False
            return node.val == head.val and (dfs(node.left, head.next) or dfs(node.right, head.next))

        def traverse(node, head):
            if not node:
                return False
            return dfs(node, head) or traverse(node.left, head) or traverse(node.right, head)

        return traverse(root, head)