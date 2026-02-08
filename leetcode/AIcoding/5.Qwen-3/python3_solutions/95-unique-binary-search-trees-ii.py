class Solution:
    def generateTrees(self, n: int) -> List[TreeNode]:
        if n == 0:
            return []

        def generate(start, end):
            if start > end:
                return [None]
            res = []
            for i in range(start, end + 1):
                left = generate(start, i - 1)
                right = generate(i + 1, end)
                for l in left:
                    for r in right:
                        root = TreeNode(i)
                        root.left = l
                        root.right = r
                        res.append(root)
            return res

        return generate(1, n)