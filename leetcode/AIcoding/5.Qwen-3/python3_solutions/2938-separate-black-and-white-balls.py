class Solution:
    def countBlackBlocks(self, n: int, m: int, x: List[int], y: List[int]) -> int:
        from collections import defaultdict

        block_count = defaultdict(int)
        for i in range(len(x)):
            row = x[i]
            col = y[i]
            if row > 0 and col > 0:
                block_count[(row - 1, col - 1)] += 1
            if row > 0 and col < m - 1:
                block_count[(row - 1, col)] += 1
            if row < n - 1 and col > 0:
                block_count[(row, col - 1)] += 1
            if row < n - 1 and col < m - 1:
                block_count[(row, col)] += 1

        result = 0
        for count in block_count.values():
            if count >= 4:
                result += 1
        return result