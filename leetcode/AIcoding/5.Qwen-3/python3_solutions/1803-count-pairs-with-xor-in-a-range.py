class Solution:
    def countPairs(self, nums: List[int], low: int, high: int) -> int:
        from collections import defaultdict

        def insert(num):
            node = root
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                if bit not in node:
                    node[bit] = {}
                node = node[bit]

        def query(num, limit):
            node = root
            res = 0
            for i in range(31, -1, -1):
                bit = (num >> i) & 1
                if (limit >> i) & 1:
                    if (bit ^ 1) in node:
                        res += node[bit ^ 1]
                    if bit in node:
                        node = node[bit]
                    else:
                        return res
                else:
                    if bit in node:
                        node = node[bit]
                    else:
                        return res
            return res

        root = {}
        res = 0
        for num in nums:
            res += query(num, high) - query(num, low - 1)
            insert(num)
        return res