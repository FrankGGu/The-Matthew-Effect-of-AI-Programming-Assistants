class Solution:
    def fairCandySwap(self, A: List[int], B: int) -> List[int]:
        sumA = sum(A)
        sumB = sum(B)
        diff = (sumB - sumA) // 2
        setB = set(B)
        for a in A:
            if a + diff in setB:
                return [a, a + diff]
        return []