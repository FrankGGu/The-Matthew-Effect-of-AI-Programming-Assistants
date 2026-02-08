class Solution:
    def findBestTarget(self, targets: List[int], s: str) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, c in enumerate(s):
            pos[c].append(i)

        res = -1
        max_count = 0
        for c in pos:
            if c not in targets:
                continue
            count = 0
            j = 0
            for i in pos[c]:
                while j < len(targets) and targets[j] < i:
                    j += 1
                if j < len(targets) and targets[j] == i:
                    count += 1
            if count > max_count:
                max_count = count
                res = ord(c) - ord('a')
        return res