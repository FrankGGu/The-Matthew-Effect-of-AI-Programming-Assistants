class Solution:
    def uncommonFromSentences(self, A: str, B: str) -> List[str]:
        from collections import Counter

        count = Counter()
        for word in A.split():
            count[word] += 1
        for word in B.split():
            count[word] += 1

        result = []
        for word in count:
            if count[word] == 1:
                result.append(word)

        return result