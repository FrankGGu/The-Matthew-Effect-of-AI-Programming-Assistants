class Solution:
    def countBits(self, n: int) -> List[int]:
        result = [0] * n
        for i in range(n):
            result[i] = bin(i).count('1')
        return result