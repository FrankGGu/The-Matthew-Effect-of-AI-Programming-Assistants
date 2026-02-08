class Solution:
    def maxTastiness(self, candyPrice: List[int], numPeople: int) -> int:
        candyPrice.sort()
        n = len(candyPrice)
        left, right = 0, n - 1
        result = 0

        while left <= right:
            if (left + right) % numPeople == 0:
                result = max(result, candyPrice[left] + candyPrice[right])
            left += 1
            right -= 1

        return result