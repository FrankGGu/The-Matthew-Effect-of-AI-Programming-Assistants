class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Codec:

    def serialize(self, root):
        """Encodes a tree to a single string.
        :type root: TreeNode
        :rtype: str
        """
        def helper(node):
            if not node:
                return 'None'
            return f"{node.val},{helper(node.left)},{helper(node.right)}"
        return helper(root)

    def deserialize(self, data):
        """Decodes your encoded data to tree.
        :type data: str
        :rtype: TreeNode
        """
        def helper(nodes):
            if nodes[0] == 'None':
                nodes.pop(0)
                return None
            root = TreeNode(int(nodes[0]))
            nodes.pop(0)
            root.left = helper(nodes)
            root.right = helper(nodes)
            return root
        return helper(data.split(','))