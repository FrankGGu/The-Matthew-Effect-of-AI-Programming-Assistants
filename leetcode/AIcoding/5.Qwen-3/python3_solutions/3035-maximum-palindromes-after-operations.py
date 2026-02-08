class Solution:
    def longestPalindrome(self, words: List[str]) -> int:
        from collections import Counter

        count = Counter(words)
        res = 0
        central = 0

        for word in count:
            if word[0] == word[1]:
                pairs = count[word] // 2
                res += pairs * 2
                if count[word] % 2 == 1:
                    central = 1
            else:
                rev = word[::-1]
                if rev in count and rev != word:
                    res += min(count[word], count[rev]) * 2
                    count[rev] = 0

        return res + central