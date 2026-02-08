class Solution:
    def tree2str(self, t: TreeNode) -> str:
        if not t:
            return ""
        left = self.tree2str(t.left)
        right = self.tree2str(t.right)
        if not left and not right:
            return str(t.val)
        if not right:
            return f"{t.val}({left})"
        return f"{t.val}({left})({right})"