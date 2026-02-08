from collections import defaultdict

class SORTracker:
    def __init__(self):
        self.heap = []
        self.count = 0

    def add(self, name: str, score: int) -> None:
        self.count += 1
        self.heap.append((-score, name, self.count))

    def query(self) -> str:
        self.heap.sort()
        return self.heap[0][1]