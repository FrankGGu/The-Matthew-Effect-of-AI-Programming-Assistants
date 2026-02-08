class Solution:
    def frequencySort(self, s: str) -> str:
        from collections import Counter
        count = Counter(s)
        sorted_chars = sorted(count.items(), key=lambda x: (-x[1], x[0]))
        result = []
        for char, freq in sorted_chars:
            result.append(char * freq)
        return ''.join(result)