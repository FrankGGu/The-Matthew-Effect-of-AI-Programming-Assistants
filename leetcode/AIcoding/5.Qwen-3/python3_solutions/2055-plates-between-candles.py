class Solution:
    def platesBetweenCandles(self, s: str, queries: List[List[int]]) -> List[int]:
        n = len(s)
        prefix = [0] * n
        left = [0] * n
        right = [0] * n

        count = 0
        for i in range(n):
            if s[i] == '*':
                count += 1
            prefix[i] = count

        left[0] = 0 if s[0] == '*' else -1
        for i in range(1, n):
            if s[i] == '*':
                left[i] = left[i-1]
            else:
                left[i] = i

        right[n-1] = n-1 if s[n-1] == '*' else -1
        for i in range(n-2, -1, -1):
            if s[i] == '*':
                right[i] = right[i+1]
            else:
                right[i] = i

        res = []
        for q in queries:
            l, r = q
            first = right[l]
            last = left[r]
            if first == -1 or last == -1 or first >= last:
                res.append(0)
            else:
                res.append(prefix[last] - prefix[first])

        return res