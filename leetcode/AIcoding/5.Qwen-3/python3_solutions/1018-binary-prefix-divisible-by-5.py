class Solution:
    def prefixesDivBy6(self, A: List[int]) -> List[bool]:
        result = []
        mod = 0
        for num in A:
            mod = (mod * 2 + num) % 6
            result.append(mod == 0)
        return result