class Solution:
    def countVowelSubstrings(self, s: str) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        count = 0
        n = len(s)
        for i in range(n):
            if s[i] not in vowels:
                continue
            seen = set()
            for j in range(i, n):
                if s[j] not in vowels:
                    break
                seen.add(s[j])
                if len(seen) == 5:
                    count += 1
        return count