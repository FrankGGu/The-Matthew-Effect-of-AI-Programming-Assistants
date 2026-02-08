class LUPrefix:
    def __init__(self, n: int):
        self.n = n
        self.uploaded = [False] * n
        self.pointer = 0

    def upload(self, video: int) -> None:
        self.uploaded[video] = True

    def longest(self) -> int:
        while self.pointer < self.n and self.uploaded[self.pointer]:
            self.pointer += 1
        return self.pointer