class Solution:
    def isPossibleToMakeZero(self, nums: List[int], queries: List[List[int]]) -> List[bool]:
        from collections import defaultdict

        def update(pos, val):
            while pos < len(bit):
                bit[pos] += val
                pos += pos & -pos

        def query(pos):
            res = 0
            while pos > 0:
                res += bit[pos]
                pos -= pos & -pos
            return res

        n = len(nums)
        bit = [0] * (n + 1)
        for i in range(n):
            update(i + 1, nums[i])

        result = []
        for a, b in queries:
            total = query(b) - query(a - 1)
            if total == 0:
                result.append(True)
            else:
                result.append(False)
        return result