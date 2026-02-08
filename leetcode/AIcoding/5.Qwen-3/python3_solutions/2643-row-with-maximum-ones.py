class Solution:
    def rowWithMax1s(self, matrix: List[List[int]]) -> int:
        max_row = -1
        max_count = 0
        for i in range(len(matrix)):
            count = sum(matrix[i])
            if count > max_count:
                max_count = count
                max_row = i
        return max_row