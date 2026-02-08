class Solution:
    def maximizeSquare(self, left: List[int], right: List[int], top: List[int], bottom: List[int]) -> int:
        from collections import defaultdict

        def getCoordinates(arr):
            arr = sorted(arr)
            coords = set()
            for i in range(len(arr)):
                for j in range(i + 1, len(arr)):
                    coords.add(arr[j] - arr[i])
            return sorted(coords)

        left_coords = getCoordinates(left)
        right_coords = getCoordinates(right)
        top_coords = getCoordinates(top)
        bottom_coords = getCoordinates(bottom)

        max_side = 0
        for l in left_coords:
            for r in right_coords:
                if l <= r:
                    width = r - l
                    for t in top_coords:
                        for b in bottom_coords:
                            if t >= b:
                                height = t - b
                                side = min(width, height)
                                if side > max_side:
                                    max_side = side
        return max_side * max_side