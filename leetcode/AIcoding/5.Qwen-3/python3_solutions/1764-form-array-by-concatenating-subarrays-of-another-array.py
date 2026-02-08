class Solution:
    def canFormArray(self, arr: List[int], key: List[List[int]]) -> bool:
        i = 0
        while i < len(arr):
            found = False
            for k in key:
                if arr[i:i+len(k)] == k:
                    i += len(k)
                    found = True
                    break
            if not found:
                return False
        return True