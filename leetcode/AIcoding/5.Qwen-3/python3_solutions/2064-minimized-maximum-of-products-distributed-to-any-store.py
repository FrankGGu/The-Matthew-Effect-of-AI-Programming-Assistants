class Solution:
    def minimizedMaximum(self, n: int, quantities: List[int]) -> int:
        def can_distribute(max_products):
            required_stores = 0
            for q in quantities:
                required_stores += (q + max_products - 1) // max_products
                if required_stores > n:
                    return False
            return required_stores <= n

        left, right = 1, max(quantities)
        while left < right:
            mid = (left + right) // 2
            if can_distribute(mid):
                right = mid
            else:
                left = mid + 1
        return left