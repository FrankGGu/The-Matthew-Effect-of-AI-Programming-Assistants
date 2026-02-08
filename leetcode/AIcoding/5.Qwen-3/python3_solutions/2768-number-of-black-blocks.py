class Solution:
    def countBlackBlocks(self, n: int, m: int, blocks: List[List[int]]) -> int:
        from collections import defaultdict

        block_count = defaultdict(int)
        for x, y in blocks:
            block_count[(x, y)] += 1

        result = 0
        for (x, y), count in block_count.items():
            if count >= 4:
                result += 1
        return result