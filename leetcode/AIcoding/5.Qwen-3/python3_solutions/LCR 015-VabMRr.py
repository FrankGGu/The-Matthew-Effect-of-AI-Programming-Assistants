from collections import defaultdict

class Solution:
    def findAnagrams(self, s: str, p: str) -> List[int]:
        len_s, len_p = len(s), len(p)
        if len_p > len_s:
            return []

        count_p = defaultdict(int)
        count_s = defaultdict(int)

        for i in range(len_p):
            count_p[p[i]] += 1
            count_s[s[i]] += 1

        result = []
        if count_p == count_s:
            result.append(0)

        for i in range(len_p, len_s):
            count_s[s[i - len_p]] -= 1
            if count_s[s[i - len_p]] == 0:
                del count_s[s[i - len_p]]
            count_s[s[i]] += 1

            if count_p == count_s:
                result.append(i - len_p + 1)

        return result