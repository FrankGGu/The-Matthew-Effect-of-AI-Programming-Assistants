class Solution:
    def countPairs(self, points: List[List[int]], k: int) -> int
        from collections import defaultdict

        def distance(p1, p2):
            return (p1[0] - p2[0])**2 + (p1[1] - p2[1])**2

        count = 0
        n = len(points)
        for i in range(n):
            for j in range(i + 1, n):
                if distance(points[i], points[j]) == k * k:
                    count += 1
        return count