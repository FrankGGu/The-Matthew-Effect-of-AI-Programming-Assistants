class Solution:
    def getCoprimesOf(self, root: TreeNode) -> List[int]:
        from collections import defaultdict

        coprimes = [i for i in range(1, 1001) if math.gcd(i, 1000) == 1]
        prime_factors = defaultdict(list)
        for i in range(1, 1001):
            for j in range(2, int(math.sqrt(i)) + 1):
                if i % j == 0:
                    prime_factors[i].append(j)
                    if i // j != j:
                        prime_factors[i].append(i // j)

        result = []
        stack = [(root, [])]
        while stack:
            node, path = stack.pop()
            current_val = node.val
            max_depth = -1
            res_val = -1
            for depth, val in path:
                if math.gcd(current_val, val) == 1 and depth > max_depth:
                    max_depth = depth
                    res_val = val
            result.append(res_val)
            new_path = [(depth + 1, val) for depth, val in path] + [(0, current_val)]
            if node.right:
                stack.append((node.right, new_path))
            if node.left:
                stack.append((node.left, new_path))
        return result