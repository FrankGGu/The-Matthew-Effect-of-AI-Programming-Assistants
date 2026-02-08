class Solution:
    def minOperations(self, target: str, original: str) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, c in enumerate(target):
            pos[c].append(i)

        dp = []
        for c in original:
            if c not in pos:
                continue
            idxs = pos[c]
            left, right = 0, len(dp)
            while left < right:
                mid = (left + right) // 2
                if dp[mid] < idxs[0]:
                    left = mid + 1
                else:
                    right = mid
            if left == len(dp):
                dp.append(idxs[0])
            else:
                dp[left] = idxs[0]
        return len(target) - len(dp)