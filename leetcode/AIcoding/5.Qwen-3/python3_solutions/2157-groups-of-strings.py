class Solution:
    def groupStrings(self, strings: List[str]) -> List[List[str]]:
        from collections import defaultdict

        def get_pattern(s):
            pattern = []
            for i in range(1, len(s)):
                diff = (ord(s[i]) - ord(s[0])) % 26
                pattern.append(str(diff))
            return tuple(pattern)

        groups = defaultdict(list)
        for s in strings:
            groups[get_pattern(s)].append(s)

        return list(groups.values())