class SnapshotArray:
    def __init__(self, length: int):
        self.data = [{} for _ in range(length)]
        self.current_id = 0

    def set(self, index: int, val: int):
        self.data[index][self.current_id] = val

    def snap(self) -> int:
        self.current_id += 1
        return self.current_id - 1

    def get(self, index: int, snap_id: int) -> int:
        return self.data[index].get(snap_id, 0)