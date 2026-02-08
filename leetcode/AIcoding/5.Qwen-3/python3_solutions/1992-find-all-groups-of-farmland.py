class Solution:
    def findFarmland(self, land: List[List[int]]) -> List[List[int]]:
        m = len(land)
        n = len(land[0])
        result = []
        visited = [[False for _ in range(n)] for _ in range(m)]

        for i in range(m):
            for j in range(n):
                if land[i][j] == 1 and not visited[i][j]:
                    x, y = i, j
                    while x + 1 < m and land[x + 1][y] == 1:
                        x += 1
                    while y + 1 < n and land[x][y + 1] == 1:
                        y += 1
                    for a in range(i, x + 1):
                        for b in range(j, y + 1):
                            visited[a][b] = True
                    result.append([i, j, x, y])
        return result