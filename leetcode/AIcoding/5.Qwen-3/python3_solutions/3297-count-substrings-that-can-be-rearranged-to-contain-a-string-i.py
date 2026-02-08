class Solution:
    def isSubstringAvailable(self, s: str, substr: str) -> bool:
        from collections import Counter
        count_s = Counter(s)
        count_substr = Counter(substr)
        for char in count_substr:
            if count_s.get(char, 0) < count_substr[char]:
                return False
        return True

    def countQuadruplets(self, s: str) -> int:
        from collections import defaultdict
        n = len(s)
        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                substr = s[i:j+1]
                if self.isSubstringAvailable(s, substr):
                    count += 1
        return count