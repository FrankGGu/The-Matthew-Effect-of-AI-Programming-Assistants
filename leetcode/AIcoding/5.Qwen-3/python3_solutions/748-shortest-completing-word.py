from collections import Counter

class Solution:
    def shortestCompletingWords(self, licensePlate: str, words: list[str]) -> list[str]:
        def count_chars(s):
            return Counter(c for c in s if c.isalpha())

        plate_count = count_chars(licensePlate)
        result = []

        for word in words:
            word_count = count_chars(word)
            if all(word_count[c] >= plate_count[c] for c in plate_count):
                result.append(word)

        return result