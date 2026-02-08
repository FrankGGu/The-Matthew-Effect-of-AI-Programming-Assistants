class Solution:
    def kWeakestRows(self, matrix: List[List[int]], k: int) -> List[int]:
        return [i for i, _ in sorted(enumerate(matrix), key=lambda x: sum(x[1]))[:k]]