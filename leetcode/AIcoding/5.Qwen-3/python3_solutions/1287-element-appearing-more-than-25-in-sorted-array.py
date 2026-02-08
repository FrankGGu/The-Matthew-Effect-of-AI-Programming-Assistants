class Solution:
    def findSpecialInteger(self, arr: List[int]) -> int:
        n = len(arr)
        if n <= 3:
            return arr[0]
        for i in range(n // 4 + 1):
            if arr[i] == arr[i + n // 4] and arr[i] == arr[i + n // 2] and arr[i] == arr[i + 3 * n // 4]:
                return arr[i]
        return -1