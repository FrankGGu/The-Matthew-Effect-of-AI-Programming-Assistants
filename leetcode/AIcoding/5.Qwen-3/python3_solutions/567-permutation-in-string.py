class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s1) > len(s2):
            return False

        count = [0] * 26
        window = [0] * 26

        for c in s1:
            count[ord(c) - ord('a')] += 1

        for i in range(len(s1)):
            window[ord(s2[i]) - ord('a')] += 1

        if window == count:
            return True

        for i in range(len(s1), len(s2)):
            window[ord(s2[i - len(s1)]) - ord('a')] -= 1
            window[ord(s2[i]) - ord('a')] += 1

            if window == count:
                return True

        return False