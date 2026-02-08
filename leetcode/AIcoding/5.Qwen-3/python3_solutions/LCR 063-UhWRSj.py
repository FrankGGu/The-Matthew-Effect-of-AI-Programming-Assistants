class Solution:
    def replaceWords(self, dictionary, sentence: str) -> str:
        words = sentence.split()
        dictionary.sort()
        for i in range(len(words)):
            for root in dictionary:
                if words[i].startswith(root):
                    words[i] = root
                    break
        return ' '.join(words)