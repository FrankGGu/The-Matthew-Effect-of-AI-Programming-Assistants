class Solution:
    def minCost(self, n: int, m: int, horizontalCut: List[int], verticalCut: List[int]) -> int:
        horizontalCut.sort()
        verticalCut.sort()

        h = len(horizontalCut)
        v = len(verticalCut)

        i = j = 0
        cost = 0
        h_count = 1
        v_count = 1

        while i < h and j < v:
            if horizontalCut[i] < verticalCut[j]:
                cost += horizontalCut[i] * v_count
                i += 1
                h_count += 1
            else:
                cost += verticalCut[j] * h_count
                j += 1
                v_count += 1

        while i < h:
            cost += horizontalCut[i] * v_count
            i += 1
            h_count += 1

        while j < v:
            cost += verticalCut[j] * h_count
            j += 1
            v_count += 1

        return cost