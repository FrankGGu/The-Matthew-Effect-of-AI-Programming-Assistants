class Solution:
    def convertToMatrix(self, original: List[int], m: int, n: int) -> List[List[int]]:
        if len(original) != m * n:
            return []
        result = []
        for i in range(m):
            result.append(original[i * n : (i + 1) * n])
        return result