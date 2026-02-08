class Solution:
    def maxLength(self, arr: List[str]) -> int:
        def has_unique_chars(s):
            return len(set(s)) == len(s)

        def backtrack(index, current):
            if index == len(arr):
                return len(current)
            res = backtrack(index + 1, current)
            if has_unique_chars(arr[index]) and len(set(current) & set(arr[index])) == 0:
                res = max(res, backtrack(index + 1, current + arr[index]))
            return res

        return backtrack(0, "")