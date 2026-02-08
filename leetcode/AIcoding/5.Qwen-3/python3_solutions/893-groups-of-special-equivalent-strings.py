class Solution:
    def numSpecialEquivGroups(self, A: List[str]) -> int:
        groups = set()
        for s in A:
            even = ''.join(sorted(s[::2]))
            odd = ''.join(sorted(s[1::2]))
            groups.add((even, odd))
        return len(groups)