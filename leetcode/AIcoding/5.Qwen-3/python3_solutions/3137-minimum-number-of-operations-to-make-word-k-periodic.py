from collections import Counter

class Solution:
    def minimumOperationsToMakeKPeriodic(self, word: str, k: int) -> int:
        n = len(word)
        count = Counter()
        for i in range(0, n, k):
            substring = word[i:i+k]
            count[substring] += 1
        max_freq = max(count.values())
        return n - max_freq * k