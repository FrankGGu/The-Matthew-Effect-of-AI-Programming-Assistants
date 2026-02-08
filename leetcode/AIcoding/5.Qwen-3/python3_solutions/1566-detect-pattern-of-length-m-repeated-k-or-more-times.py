from typing import List

class Solution:
    def containsPattern(self, arr: List[int], m: int, k: int) -> bool:
        n = len(arr)
        for i in range(n - m * k + 1):
            pattern = arr[i:i+m]
            valid = True
            for j in range(1, k):
                if arr[i + j * m:i + (j + 1) * m] != pattern:
                    valid = False
                    break
            if valid:
                return True
        return False