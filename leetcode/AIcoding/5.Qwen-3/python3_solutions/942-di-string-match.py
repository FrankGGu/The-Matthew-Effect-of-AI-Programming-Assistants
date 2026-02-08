class Solution:
    def diStringMatch(self, s: str) -> List[int]:
        low = 0
        high = len(s)
        result = []
        for c in s:
            if c == 'I':
                result.append(low)
                low += 1
            else:
                result.append(high)
                high -= 1
        result.append(low)
        return result