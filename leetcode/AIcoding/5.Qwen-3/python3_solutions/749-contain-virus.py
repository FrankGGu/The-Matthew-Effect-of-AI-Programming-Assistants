class Solution:
    def containVirus(self, isInfected: List[List[int]]) -> int:
        from collections import deque

        def bfs(i, j, visited):
            q = deque()
            q.append((i, j))
            visited[i][j] = True
            area = [(i, j)]
            borders = set()
            while q:
                x, y = q.popleft()
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < len(isInfected) and 0 <= ny < len(isInfected[0]):
                        if not isInfected[nx][ny] and (nx, ny) not in borders:
                            borders.add((nx, ny))
                        elif isInfected[nx][ny] and not visited[nx][ny]:
                            visited[nx][ny] = True
                            q.append((nx, ny))
                            area.append((nx, ny))
            return area, borders

        result = 0
        while True:
            visited = [[False for _ in range(len(isInfected[0]))] for _ in range(len(isInfected))]
            areas = []
            for i in range(len(isInfected)):
                for j in range(len(isInfected[0])):
                    if isInfected[i][j] and not visited[i][j]:
                        area, borders = bfs(i, j, visited)
                        areas.append((area, borders))
            if not areas:
                break
            max_borders = -1
            idx = -1
            for i, (area, borders) in enumerate(areas):
                if len(borders) > max_borders:
                    max_borders = len(borders)
                    idx = i
            result += len(areas[idx][0])
            for i, (area, borders) in enumerate(areas):
                if i == idx:
                    for x, y in area:
                        isInfected[x][y] = False
                else:
                    for x, y in borders:
                        isInfected[x][y] = True
        return result