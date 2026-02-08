import bisect

class Solution:
    def maxEnvelopes(self, envelopes: List[List[int]]) -> int:
        envelopes.sort(key=lambda x: (x[0], x[1]))
        dp = []
        for h, w in envelopes:
            idx = bisect.bisect_left(dp, w)
            if idx == len(dp):
                dp.append(w)
            else:
                dp[idx] = w
        return len(dp)