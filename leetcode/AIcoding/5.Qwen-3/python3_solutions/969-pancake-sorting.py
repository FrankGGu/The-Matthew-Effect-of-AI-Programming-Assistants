class Solution:
    def pancakeSort(self, arr: List[int]) -> List[int]:
        n = len(arr)
        res = []
        for i in range(n, 0, -1):
            idx = arr.index(i)
            if idx == i - 1:
                continue
            if idx != 0:
                res.append(idx + 1)
                arr[:idx+1] = arr[:idx+1][::-1]
            res.append(i)
            arr[:i] = arr[:i][::-1]
        return res