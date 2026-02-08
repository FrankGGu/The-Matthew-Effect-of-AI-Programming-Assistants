class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        row1 = set("qwertyuiop")
        row2 = set("asdfghjkl")
        row3 = set("zxcvbnm")
        result = []
        for word in words:
            if set(word.lower()) <= row1 or set(word.lower()) <= row2 or set(word.lower()) <= row3:
                result.append(word)
        return result