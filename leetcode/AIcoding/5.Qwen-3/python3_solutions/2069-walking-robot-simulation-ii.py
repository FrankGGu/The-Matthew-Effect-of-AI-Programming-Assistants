class Robot:
    def __init__(self, width: int, height: int):
        self.width = width
        self.height = height
        self.x = 0
        self.y = 0
        self.direction = 0  # 0: right, 1: up, 2: left, 3: down
        self.dirs = [(1, 0), (0, 1), (-1, 0), (0, -1)]

    def move(self, d: int) -> None:
        for _ in range(d):
            nx, ny = self.x + self.dirs[self.direction][0], self.y + self.dirs[self.direction][1]
            if 0 <= nx < self.width and 0 <= ny < self.height:
                self.x, self.y = nx, ny
            else:
                self.direction = (self.direction + 1) % 4

    def getPos(self):
        return [self.x, self.y]

    def getDir(self):
        directions = ["East", "North", "West", "South"]
        return directions[self.direction]