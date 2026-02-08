class Solution:
    def findXValue(self, array: List[int]) -> int:
        from collections import Counter

        count = Counter(array)
        for x in range(1, max(array) + 1):
            if count[x] == x:
                return x
        return -1