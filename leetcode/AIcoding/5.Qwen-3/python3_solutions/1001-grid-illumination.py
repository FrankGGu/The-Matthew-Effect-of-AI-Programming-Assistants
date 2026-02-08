class Solution:
    def gridIllumination(self, N: int, lamps: List[List[int]], queries: List[List[int]]) -> List[bool]:
        from collections import defaultdict

        lamp_set = set()
        row_count = defaultdict(int)
        col_count = defaultdict(int)
        diag1_count = defaultdict(int)
        diag2_count = defaultdict(int)

        for x, y in lamps:
            if (x, y) not in lamp_set:
                lamp_set.add((x, y))
                row_count[x] += 1
                col_count[y] += 1
                diag1_count[x - y] += 1
                diag2_count[x + y] += 1

        result = []

        for x, y in queries:
            if row_count[x] > 0 or col_count[y] > 0 or diag1_count[x - y] > 0 or diag2_count[x + y] > 0:
                result.append(True)
            else:
                result.append(False)

            if (x, y) in lamp_set:
                lamp_set.remove((x, y))
                row_count[x] -= 1
                col_count[y] -= 1
                diag1_count[x - y] -= 1
                diag2_count[x + y] -= 1

        return result