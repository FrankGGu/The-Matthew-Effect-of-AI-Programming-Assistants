class Solution:
    def isIdealWeight(self, A: List[int]) -> bool:
        for i in range(len(A)):
            if abs(A[i] - i) > 1:
                return False
        return True