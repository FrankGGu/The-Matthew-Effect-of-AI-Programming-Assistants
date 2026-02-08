class Solution:
    def maximumValue(self, strList: List[str]) -> int:
        max_val = 0
        for s in strList:
            if s.isdigit():
                max_val = max(max_val, int(s))
            else:
                max_val = max(max_val, len(s))
        return max_val