class Solution:
    def countBeautifulSubstrings(self, s: str) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        n = len(s)
        result = 0
        for i in range(n):
            vowel_count = 0
            consonant_count = 0
            for j in range(i, n):
                if s[j] in vowels:
                    vowel_count += 1
                else:
                    consonant_count += 1
                if vowel_count == consonant_count:
                    result += 1
        return result