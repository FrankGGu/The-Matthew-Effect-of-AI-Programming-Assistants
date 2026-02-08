class Solution:
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:
        def inorder(node):
            return inorder(node.left) + [node.val] + inorder(node.right) if node else []

        list1 = inorder(root1)
        list2 = inorder(root2)

        i = j = 0
        result = []

        while i < len(list1) and j < len(list2):
            if list1[i] < list2[j]:
                result.append(list1[i])
                i += 1
            else:
                result.append(list2[j])
                j += 1

        while i < len(list1):
            result.append(list1[i])
            i += 1

        while j < len(list2):
            result.append(list2[j])
            j += 1

        return result