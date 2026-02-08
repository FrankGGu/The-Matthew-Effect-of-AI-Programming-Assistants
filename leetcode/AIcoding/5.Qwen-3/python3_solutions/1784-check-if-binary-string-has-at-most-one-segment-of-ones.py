class Solution:
    def checkIfOneSegment(self, s: str) -> bool:
        found_one = False
        for c in s:
            if c == '1':
                found_one = True
            elif found_one and c == '0':
                return False
        return True