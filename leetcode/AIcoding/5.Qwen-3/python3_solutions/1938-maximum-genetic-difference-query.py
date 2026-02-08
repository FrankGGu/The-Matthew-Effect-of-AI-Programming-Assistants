class Solution:
    def __init__(self):
        self.root = {}

    def insert(self, num):
        node = self.root
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            if bit not in node:
                node[bit] = {}
            node = node[bit]

    def max_xor(self, num):
        node = self.root
        max_xor = 0
        for i in range(31, -1, -1):
            bit = (num >> i) & 1
            toggle_bit = 1 - bit
            if toggle_bit in node:
                max_xor |= (1 << i)
                node = node[toggle_bit]
            else:
                node = node.get(bit, {})
        return max_xor

    def maxGeneticDifference(self, parents, queries):
        from collections import defaultdict
        tree = defaultdict(list)
        for i, p in enumerate(parents):
            tree[p].append(i)

        result = [0] * len(queries)

        def dfs(node, parent):
            self.insert(node)
            for child in tree[node]:
                dfs(child, node)
            for idx, (q_node, q_val) in queries:
                if q_node == node:
                    result[idx] = self.max_xor(q_val)
            self.insert(node)

        dfs(0, -1)
        return result