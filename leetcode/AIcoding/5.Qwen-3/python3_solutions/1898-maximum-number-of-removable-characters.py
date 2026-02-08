class Solution:
    def maximumRemovable(self, s: str, p: str) -> int:
        def is_subsequence(s, p, indices):
            i = 0
            for j in indices:
                if i < len(p) and s[j] == p[i]:
                    i += 1
            return i == len(p)

        left, right = 0, len(s)
        result = 0
        while left <= right:
            mid = (left + right) // 2
            indices = []
            for i in range(len(s)):
                if s[i] != p[len(indices)] if indices else True:
                    indices.append(i)
                if len(indices) > len(p):
                    break
            if len(indices) >= len(p) and is_subsequence(s, p, indices):
                result = mid
                left = mid + 1
            else:
                right = mid - 1
        return result