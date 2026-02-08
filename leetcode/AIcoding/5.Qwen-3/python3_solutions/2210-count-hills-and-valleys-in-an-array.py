class Solution:
    def countHillValley(self, arr: List[int]) -> int:
        count = 0
        n = len(arr)
        for i in range(1, n - 1):
            if arr[i] > arr[i - 1] and arr[i] > arr[i + 1]:
                count += 1
            elif arr[i] < arr[i - 1] and arr[i] < arr[i + 1]:
                count += 1
        return count