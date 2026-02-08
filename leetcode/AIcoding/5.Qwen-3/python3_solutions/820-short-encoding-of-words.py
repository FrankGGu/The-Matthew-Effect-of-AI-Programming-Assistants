class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        words = list(set(words))
        words.sort(key=lambda x: -len(x))
        encoding = ""
        for word in words:
            if word not in encoding:
                encoding += word + "#"
        return len(encoding)