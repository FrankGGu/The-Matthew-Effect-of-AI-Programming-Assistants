class Solution:
    def minFlowers(self, flowerbed: List[int], cnt: int) -> int:
        n = len(flowerbed)
        i = 0
        res = 0
        while i < n and cnt > 0:
            if flowerbed[i] == 0:
                left = i == 0 or flowerbed[i - 1] == 0
                right = i == n - 1 or flowerbed[i + 1] == 0
                if left and right:
                    flowerbed[i] = 1
                    res += 1
                    cnt -= 1
                    i += 2
                else:
                    i += 1
            else:
                i += 1
        return res if cnt == 0 else -1