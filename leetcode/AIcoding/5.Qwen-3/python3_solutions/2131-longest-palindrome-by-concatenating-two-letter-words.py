class Solution:
    def longestPalindrome(self, words: List[str]) -> int:
        from collections import Counter

        count = Counter(words)
        max_length = 0
        middle = False

        for word in count:
            if word[0] == word[1]:
                if count[word] % 2 == 1:
                    max_length += (count[word] - 1) * 2
                    middle = True
                else:
                    max_length += count[word] * 2
            else:
                rev = word[::-1]
                if rev in count and rev != word:
                    max_length += min(count[word], count[rev]) * 2

        if middle:
            max_length += 2

        return max_length