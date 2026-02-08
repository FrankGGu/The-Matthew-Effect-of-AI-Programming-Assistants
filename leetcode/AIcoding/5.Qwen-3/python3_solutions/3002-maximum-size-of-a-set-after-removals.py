class Solution:
    def maximumSet(self, nums: List[int], n: int) -> int:
        from collections import Counter

        count = Counter(nums)
        freq = list(count.values())
        freq.sort()

        res = 0
        for f in freq:
            if f <= n:
                res += f
                n -= f
            else:
                res += n
                break
        return res