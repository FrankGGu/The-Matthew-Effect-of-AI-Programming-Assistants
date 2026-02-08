class Solution:
    def maxEnergy(self, energy: List[int], k: int) -> int:
        n = len(energy)
        for i in range(k, n):
            energy[i] += energy[i - k]
        return max(energy)