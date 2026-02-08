class Solution:
    def maxSumSubmatrix(self, matrix: List[List[int]], k: int) -> int:
        import bisect
        rows, cols = len(matrix), len(matrix[0])
        res = float('-inf')

        for left in range(cols):
            temp = [0] * rows
            for right in range(left, cols):
                for i in range(rows):
                    temp[i] += matrix[i][right]
                arr = [0]
                curr = 0
                for num in temp:
                    curr += num
                    idx = bisect.bisect_left(arr, curr - k)
                    if idx < len(arr):
                        res = max(res, curr - arr[idx])
                    bisect.insort(arr, curr)
        return res