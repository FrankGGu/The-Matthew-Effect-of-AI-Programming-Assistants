class Solution:
    def maxDistance(self, points: List[List[int]], k: int) -> int:
        from collections import defaultdict

        def getTransformedPoints(points):
            transformed = []
            for x, y in points:
                transformed.append((x + y, x - y))
            return transformed

        transformed = getTransformedPoints(points)

        def findMaxDistance(transformed, k):
            max1 = max2 = -float('inf')
            min1 = min2 = float('inf')

            for a, b in transformed:
                if a > max1:
                    max1 = a
                elif a > max2:
                    max2 = a

                if a < min1:
                    min1 = a
                elif a < min2:
                    min2 = a

                if b > max1:
                    max1 = b
                elif b > max2:
                    max2 = b

                if b < min1:
                    min1 = b
                elif b < min2:
                    min2 = b

            candidates = [max1 - min1, max1 - min2, max2 - min1, max2 - min2]
            return max(candidates)

        return findMaxDistance(transformed, k)