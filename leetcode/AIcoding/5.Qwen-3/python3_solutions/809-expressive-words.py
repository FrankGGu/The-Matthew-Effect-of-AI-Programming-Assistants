class Solution:
    def expressiveWords(self, s: str, words: list[str]) -> int:
        def get_groups(s):
            groups = []
            i = 0
            while i < len(s):
                j = i
                while j < len(s) and s[j] == s[i]:
                    j += 1
                groups.append((s[i], j - i))
                i = j
            return groups

        target = get_groups(s)
        count = 0
        for word in words:
            groups = get_groups(word)
            if len(groups) != len(target):
                continue
            valid = True
            for (c1, n1), (c2, n2) in zip(target, groups):
                if c1 != c2 or (n1 < n2) or (n1 == n2 and n1 < 3) or (n1 > n2 and n1 < 3):
                    valid = False
                    break
            if valid:
                count += 1
        return count