class Solution:
    def maxBoxes(self, positions: List[int], containers: List[int]) -> int:
        positions.sort()
        containers.sort()
        i = 0
        j = 0
        count = 0
        while i < len(positions) and j < len(containers):
            if positions[i] <= containers[j]:
                count += 1
                i += 1
                j += 1
            elif positions[i] > containers[j]:
                j += 1
        return count