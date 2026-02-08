class Solution:
    def minNumberOfFrogsCroaking(self, croak: str) -> int
        from collections import defaultdict

        count = defaultdict(int)
        mapping = {'c': 'r', 'r': 'a', 'a': 'k', 'k': 'c'}
        for ch in croak:
            if count[mapping[ch]] == 0:
                return -1
            count[mapping[ch]] -= 1
            count[ch] += 1
        return count['c']