class Solution:
    def areMatricesEqual(self, matrix1, matrix2):
        return matrix1 == matrix2

    def findCyclicShifts(self, matrix):
        rows = len(matrix)
        cols = len(matrix[0])
        shifts = set()
        for i in range(cols):
            shifted = []
            for row in matrix:
                shifted_row = row[i:] + row[:i]
                shifted.append(shifted_row)
            shifts.add(tuple(tuple(row) for row in shifted))
        return shifts

    def areSimilar(self, matrix, mat):
        return self.areMatricesEqual(matrix, mat)

    def matrixSimilarity(self, matrix, mat):
        if len(matrix) != len(mat) or len(matrix[0]) != len(mat[0]):
            return False
        rows = len(matrix)
        cols = len(matrix[0])
        for i in range(cols):
            shifted = []
            for r in range(rows):
                shifted_row = matrix[r][i:] + matrix[r][:i]
                shifted.append(shifted_row)
            if self.areMatricesEqual(shifted, mat):
                return True
        return False