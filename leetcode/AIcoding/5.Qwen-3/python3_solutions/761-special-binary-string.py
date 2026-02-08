class Solution:
    def splitLoopedString(self, s: str) -> str:
        def reverse(s):
            return s[::-1]

        def generate(s):
            res = []
            for i in range(len(s)):
                if s[i] == '0':
                    res.append(reverse(s[i:] + s[:i]))
                else:
                    res.append(s[i:] + s[:i])
            return res

        s_list = generate(s)
        max_str = ''
        for i in range(len(s)):
            for j in range(len(s_list[i])):
                current = s_list[i][j:] + s_list[i][:j]
                if current > max_str:
                    max_str = current
        return max_str