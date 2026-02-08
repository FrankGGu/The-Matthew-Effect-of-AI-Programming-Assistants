class Solution:
    def longestDecomposition(self, s: str) -> int:
        def is_palindrome(sub):
            return sub == sub[::-1]

        left = 0
        right = len(s)
        result = 0

        while left < right:
            for i in range(left + 1, right + 1):
                if is_palindrome(s[left:i]):
                    result += 1
                    left = i
                    break
            else:
                return 0

        return result