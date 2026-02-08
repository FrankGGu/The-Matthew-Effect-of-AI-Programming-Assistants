class Solution:
    def transformArray(self, arr: List[int]) -> List[int]:
        n = len(arr)
        new_arr = arr[:]
        for i in range(1, n - 1):
            if arr[i - 1] < arr[i] and arr[i] > arr[i + 1]:
                new_arr[i] -= 1
            elif arr[i - 1] > arr[i] and arr[i] < arr[i + 1]:
                new_arr[i] += 1
        return new_arr