class Solution:
    def minSwapsCouples(self, row: List[int]) -> int:
        pos = [0] * len(row)
        for i in range(len(row)):
            pos[row[i]] = i

        swaps = 0
        for i in range(0, len(row), 2):
            x = row[i]
            y = row[i] ^ 1
            if row[i + 1] != y:
                j = pos[y]
                pos[row[i + 1]] = j
                pos[y] = i + 1
                row[i + 1], row[j] = row[j], row[i + 1]
                swaps += 1
        return swaps