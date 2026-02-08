class Solution:
    def valueAfterKSeconds(self, n: int, k: int) -> int:
        arr = [1] * n
        for _ in range(k):
            for i in range(1, n):
                arr[i] += arr[i - 1]
        return arr[-1]