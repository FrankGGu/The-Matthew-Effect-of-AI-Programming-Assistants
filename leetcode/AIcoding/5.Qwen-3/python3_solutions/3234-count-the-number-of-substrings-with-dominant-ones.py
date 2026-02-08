class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        count = [0] * 3
        left = 0
        result = 0
        for right in range(len(s)):
            count[int(s[right])] += 1
            while count[0] > 0 and count[1] > 0 and count[2] > 0:
                count[int(s[left])] -= 1
                left += 1
            result += left
        return result