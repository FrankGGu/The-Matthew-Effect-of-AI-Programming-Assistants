class Solution:
    def eliminateMaximum(self, target: List[int], arr: List[int]) -> int
        n = len(target)
        time = [target[i] / arr[i] for i in range(n)]
        time.sort()
        for i in range(n):
            if time[i] < i:
                return i
        return n