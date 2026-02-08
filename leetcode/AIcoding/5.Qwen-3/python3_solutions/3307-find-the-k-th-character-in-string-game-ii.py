class Solution:
    def kthCharacter(self, word: str, k: int) -> str:
        def build_string(n):
            s = 'a'
            for _ in range(n):
                next_s = ''
                for c in s:
                    next_s += chr(ord(c) + 1) if c != 'z' else 'a'
                s = next_s
            return s

        s = build_string(len(word))
        return s[k - 1]