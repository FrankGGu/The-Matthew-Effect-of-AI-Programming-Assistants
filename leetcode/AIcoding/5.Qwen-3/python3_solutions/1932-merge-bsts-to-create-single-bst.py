class Solution:
    def mergeBSTs(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> Optional[TreeNode]:
        def inorder(node):
            if not node:
                return []
            return inorder(node.left) + [node.val] + inorder(node.right)

        def buildBST(sorted_list):
            if not sorted_list:
                return None
            mid = len(sorted_list) // 2
            node = TreeNode(sorted_list[mid])
            node.left = buildBST(sorted_list[:mid])
            node.right = buildBST(sorted_list[mid+1:])
            return node

        list1 = inorder(root1)
        list2 = inorder(root2)
        merged = []
        i = j = 0
        while i < len(list1) and j < len(list2):
            if list1[i] < list2[j]:
                merged.append(list1[i])
                i += 1
            else:
                merged.append(list2[j])
                j += 1
        merged += list1[i:]
        merged += list2[j:]
        return buildBST(merged)