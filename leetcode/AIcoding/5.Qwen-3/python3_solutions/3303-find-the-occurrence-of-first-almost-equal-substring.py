class Solution:
    def findSubstring(self, s: str, p: str) -> int:
        from collections import defaultdict

        len_s = len(s)
        len_p = len(p)
        if len_p == 0 or len_s < len_p:
            return -1

        count_p = defaultdict(int)
        for char in p:
            count_p[char] += 1

        window = defaultdict(int)
        required = len(count_p)
        formed = 0
        left = 0
        result = -1

        for right in range(len_s):
            char = s[right]
            window[char] += 1

            if window[char] == count_p[char]:
                formed += 1

            while formed == required and right - left + 1 >= len_p:
                if right - left + 1 == len_p:
                    result = left
                    return result

                left_char = s[left]
                window[left_char] -= 1
                if window[left_char] < count_p[left_char]:
                    formed -= 1
                left += 1

        return result