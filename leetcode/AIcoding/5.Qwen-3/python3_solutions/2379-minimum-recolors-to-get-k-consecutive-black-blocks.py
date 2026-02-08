class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int
        min_recolors = float('inf')
        for i in range(len(blocks) - k + 1):
            window = blocks[i:i+k]
            count = window.count('b')
            min_recolors = min(min_recols, k - count)
        return min_recolors