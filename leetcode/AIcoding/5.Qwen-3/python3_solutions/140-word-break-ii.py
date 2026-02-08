class Solution:
    def wordBreak(self, s: str, wordDict: set) -> list:
        memo = {}

        def helper(s):
            if s in memo:
                return memo[s]
            result = []
            for word in wordDict:
                if s.startswith(word):
                    if len(s) == len(word):
                        result.append(word)
                    else:
                        for sub in helper(s[len(word):]):
                            result.append(word + ' ' + sub)
            memo[s] = result
            return result

        return helper(s)