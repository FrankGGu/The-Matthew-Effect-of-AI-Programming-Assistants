class Solution:
    def numberOfBeams(self, bank: List[str]) -> int:
        counts = []
        for row in bank:
            cnt = row.count('1')
            if cnt > 0:
                counts.append(cnt)
        res = 0
        for i in range(1, len(counts)):
            res += counts[i-1] * counts[i]
        return res