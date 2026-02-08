class Solution:
    def largestCombination(self, candidates: List[int]) -> int:
        max_count = 0
        for i in range(32):
            count = 0
            for num in candidates:
                if (num >> i) & 1:
                    count += 1
            max_count = max(max_count, count)
        return max_count