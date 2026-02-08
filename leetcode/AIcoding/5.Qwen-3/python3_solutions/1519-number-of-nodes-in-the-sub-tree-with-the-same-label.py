class Solution:
    def countNodes(self, root: 'TreeNode', s: str) -> int:
        self.result = [0] * len(s)

        def dfs(node):
            if not node:
                return [0] * 26
            count = [0] * 26
            for child in [node.left, node.right]:
                child_count = dfs(child)
                for i in range(26):
                    count[i] += child_count[i]
            index = ord(s[node.val]) - ord('a')
            count[index] += 1
            self.result[node.val] = count[index]
            return count

        dfs(root)
        return sum(self.result)