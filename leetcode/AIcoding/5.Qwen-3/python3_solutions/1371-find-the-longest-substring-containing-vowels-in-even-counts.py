class Solution:
    def findTheLongestSubstring(self, s: str) -> int:
        map = {0: -1}
        max_len = 0
        state = 0
        for i, c in enumerate(s):
            if c == 'a':
                state ^= 1 << 0
            elif c == 'e':
                state ^= 1 << 1
            elif c == 'i':
                state ^= 1 << 2
            elif c == 'o':
                state ^= 1 << 3
            elif c == 'u':
                state ^= 1 << 4
            if state in map:
                max_len = max(max_len, i - map[state])
            else:
                map[state] = i
        return max_len