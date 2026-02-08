class Solution:
    def checkIfCanBreak(self, s1: str, s2: str) -> bool:
        s1_sorted = sorted(s1)
        s2_sorted = sorted(s2)
        return all(c1 >= c2 for c1, c2 in zip(s1_sorted, s2_sorted)) or all(c1 <= c2 for c1, c2 in zip(s1_sorted, s2_sorted))