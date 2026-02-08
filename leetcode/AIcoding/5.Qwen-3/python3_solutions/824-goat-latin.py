class Solution:
    def toGoatLatin(self, sentence: str) -> str:
        words = sentence.split()
        result = []
        for i, word in enumerate(words):
            if word[0] in 'aeiouAEIOU':
                result.append(word + 'ma')
            else:
                result.append(word[1:] + word[0] + 'ma')
            result[-1] += 'a' * (i + 1)
        return ' '.join(result)