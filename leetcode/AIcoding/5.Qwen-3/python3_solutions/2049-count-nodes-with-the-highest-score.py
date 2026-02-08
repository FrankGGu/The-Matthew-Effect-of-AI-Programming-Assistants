class Solution:
    def countHighestScoreNodes(self, root: Optional[TreeNode]) -> int:
        self.max_score = 0
        self.count = 0

        def get_subtree_size(node):
            if not node:
                return 0
            left = get_subtree_size(node.left)
            right = get_subtree_size(node.right)
            score = 1
            if left > 0:
                score *= left
            if right > 0:
                score *= right
            if (left + right + 1) != len(self.sizes):
                score *= (len(self.sizes) - (left + right + 1))
            if score > self.max_score:
                self.max_score = score
                self.count = 1
            elif score == self.max_score:
                self.count += 1
            return left + right + 1

        self.sizes = []
        get_subtree_size(root)
        return self.count