class Solution:
    def manhattanDistances(self, pieces: List[List[int]]) -> List[int]:
        from itertools import permutations

        def distance(p1, p2):
            return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

        result = []
        for perm in permutations(pieces):
            total = 0
            for i in range(len(perm) - 1):
                total += distance(perm[i][0], perm[i+1][0])
            result.append(total)
        return result