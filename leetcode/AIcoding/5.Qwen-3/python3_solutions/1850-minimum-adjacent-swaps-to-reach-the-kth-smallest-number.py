class Solution:
    def getMinSwaps(self, number: str, k: int) -> int:
        from itertools import permutations

        s = list(number)
        n = len(s)

        for _ in range(k - 1):
            i = n - 2
            while i >= 0 and s[i] >= s[i + 1]:
                i -= 1
            j = n - 1
            while s[j] <= s[i]:
                j -= 1
            s[i], s[j] = s[j], s[i]
            s[i + 1:] = reversed(s[i + 1:])

        target = s[:]
        original = list(number)

        swaps = 0
        for i in range(len(original)):
            if original[i] == target[i]:
                continue
            j = i + 1
            while j < len(original) and original[j] != target[i]:
                j += 1
            while j > i:
                original[j], original[j - 1] = original[j - 1], original[j]
                swaps += 1
                j -= 1
        return swaps