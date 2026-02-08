class Solution:
    def validStrings(self, n: int) -> List[str]:
        def backtrack(s):
            if len(s) == n:
                result.append(s)
                return
            if s[-1] == '0':
                backtrack(s + '1')
            else:
                backtrack(s + '0')
                backtrack(s + '1')

        result = []
        if n == 0:
            return result
        backtrack('0')
        backtrack('1')
        return result