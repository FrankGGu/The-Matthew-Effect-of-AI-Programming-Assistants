class Solution:
    def findArray(self, subsetSums: List[int]) -> List[int]:
        from collections import Counter

        subsetSums.sort()
        n = len(subsetSums)
        res = []
        cnt = Counter(subsetSums)
        total = subsetSums[-1]
        for i in range(n - 1, -1, -1):
            if cnt[subsetSums[i]] == 0:
                continue
            val = subsetSums[i]
            cnt[val] -= 1
            res.append(val)
            for j in range(len(res) - 1, -1, -1):
                if cnt[val + res[j]] > 0:
                    cnt[val + res[j]] -= 1
                else:
                    return []
        return res