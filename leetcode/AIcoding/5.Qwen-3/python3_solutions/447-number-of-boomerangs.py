class Solution:
    def numberOfBoomerangs(self, points: List[List[int]]) -> int:
        from collections import defaultdict

        res = 0
        for p in points:
            dist_map = defaultdict(int)
            for q in points:
                if p != q:
                    dx = p[0] - q[0]
                    dy = p[1] - q[1]
                    dist = dx * dx + dy * dy
                    dist_map[dist] += 1
            for count in dist_map.values():
                res += count * (count - 1)
        return res