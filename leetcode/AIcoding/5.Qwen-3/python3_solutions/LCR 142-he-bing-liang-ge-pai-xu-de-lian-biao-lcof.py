class Solution:
    def trainingPlan(self, root: Optional[ListNode], cnt: int) -> int:
        def dfs(node):
            if not node:
                return 0
            left = dfs(node.next)
            if left == cnt - 1:
                self.result = node.val
            return left + 1

        self.result = 0
        dfs(root)
        return self.result