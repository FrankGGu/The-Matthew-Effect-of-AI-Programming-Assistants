class Solution:
    def countBeautifulSubstrings(self, words: List[str]) -> int:
        vowels = {'a', 'e', 'i', 'o', 'u'}
        count = 0
        for word in words:
            vowel_count = 0
            for ch in word:
                if ch in vowels:
                    vowel_count += 1
            if len(word) % 2 == 0 and vowel_count == len(word) // 2:
                count += 1
        return count