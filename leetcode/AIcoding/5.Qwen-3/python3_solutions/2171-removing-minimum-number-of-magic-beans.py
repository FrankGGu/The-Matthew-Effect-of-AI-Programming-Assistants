class Solution:
    def minimumRemovals(self, beans: List[int]) -> int:
        beans.sort()
        total = sum(beans)
        n = len(beans)
        min_removal = float('inf')
        for i in range(n):
            current = beans[i] * (n - i)
            removal = total - current
            min_removal = min(min_removal, removal)
        return min_removal