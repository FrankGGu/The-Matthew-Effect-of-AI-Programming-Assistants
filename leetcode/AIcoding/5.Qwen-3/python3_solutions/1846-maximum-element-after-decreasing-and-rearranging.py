class Solution:
    def maximumElementAfterDecreasingAndRearranging(self, arr: List[int]) -> int:
        arr.sort()
        arr[-1] = len(arr)
        for i in range(len(arr)-2, -1, -1):
            if arr[i] >= arr[i+1]:
                arr[i] = arr[i+1] - 1
        return arr[0]