class Solution:
    def minIncrMoves(self, target: List[int], m: int) -> int:
        res = 0
        for i in range(len(target)):
            if i == 0:
                res += target[i]
            else:
                res += max(0, target[i] - target[i-1])
        return res