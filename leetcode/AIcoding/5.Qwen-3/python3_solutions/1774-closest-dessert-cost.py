class Solution:
    def closest DessertCost(self, price: List[int], cost: int, *args: int) -> int:
        from itertools import product

        def dfs(i, curr):
            if i == len(price):
                return curr
            res = dfs(i + 1, curr)
            for j in range(1, 3):
                res = min(res, dfs(i + 1, curr + price[i] * j))
            return res

        res = dfs(0, 0)
        for c in args:
            res = min(res, dfs(0, c))
        return res