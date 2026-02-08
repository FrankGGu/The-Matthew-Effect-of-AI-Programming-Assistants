class Solution:
    def minTrainingHours(self, energy: List[int], training: List[int]) -> int:
        total = 0
        for e, t in zip(energy, training):
            if e < t:
                total += t - e
        return total