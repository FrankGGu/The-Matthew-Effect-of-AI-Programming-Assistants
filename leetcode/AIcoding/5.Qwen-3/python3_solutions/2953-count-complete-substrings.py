class Solution:
    def countCompleteSubstrings(self, s: str) -> int:
        def isComplete(sub):
            chars = set(sub)
            return len(chars) == 26 and all(ord(c) - ord('a') in range(26) for c in chars)

        count = 0
        n = len(s)
        for i in range(n):
            seen = set()
            for j in range(i, n):
                if s[j] in seen:
                    break
                seen.add(s[j])
                if isComplete(s[i:j+1]):
                    count += 1
        return count