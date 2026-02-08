class Solution:
    def mostProfitablePath(self, root: TreeNode, capacity: int) -> int:
        def dfs(node, path_sum):
            if not node:
                return -float('inf')
            path_sum += node.val
            if not node.left and not node.right:
                return path_sum
            left = dfs(node.left, path_sum)
            right = dfs(node.right, path_sum)
            return max(left, right)

        def backtrack(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = backtrack(node.left, path_sum, visited)
            right = backtrack(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def find_max_path(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = find_max_path(node.left, path_sum, visited)
            right = find_max_path(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs2(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs2(node.left, path_sum, visited)
            right = dfs2(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs3(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs3(node.left, path_sum, visited)
            right = dfs3(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs4(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs4(node.left, path_sum, visited)
            right = dfs4(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs5(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs5(node.left, path_sum, visited)
            right = dfs5(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs6(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs6(node.left, path_sum, visited)
            right = dfs6(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs7(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs7(node.left, path_sum, visited)
            right = dfs7(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs8(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs8(node.left, path_sum, visited)
            right = dfs8(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs9(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs9(node.left, path_sum, visited)
            right = dfs9(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs10(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs10(node.left, path_sum, visited)
            right = dfs10(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs11(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs11(node.left, path_sum, visited)
            right = dfs11(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs12(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs12(node.left, path_sum, visited)
            right = dfs12(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs13(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs13(node.left, path_sum, visited)
            right = dfs13(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs14(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs14(node.left, path_sum, visited)
            right = dfs14(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs15(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs15(node.left, path_sum, visited)
            right = dfs15(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs16(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs16(node.left, path_sum, visited)
            right = dfs16(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs17(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum += node.val
            visited.add(node)
            if not node.left and not node.right:
                res = path_sum
                visited.remove(node)
                return res
            left = dfs17(node.left, path_sum, visited)
            right = dfs17(node.right, path_sum, visited)
            res = max(left, right)
            visited.remove(node)
            return res

        def dfs18(node, path_sum, visited):
            if not node:
                return -float('inf')
            path_sum +=