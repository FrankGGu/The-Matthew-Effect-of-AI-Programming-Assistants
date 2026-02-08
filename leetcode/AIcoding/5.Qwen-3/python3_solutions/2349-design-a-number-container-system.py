class NumberContainer:
    def __init__(self):
        self.container = {}
        self.index_map = {}

    def change(self, index: int, number: int) -> None:
        if index in self.container:
            old_number = self.container[index]
            if old_number in self.index_map:
                self.index_map[old_number].discard(index)
                if not self.index_map[old_number]:
                    del self.index_map[old_number]
        self.container[index] = number
        if number not in self.index_map:
            self.index_map[number] = set()
        self.index_map[number].add(index)

    def find(self, index: int) -> int:
        return self.container.get(index, -1)

    def getAll(self) -> List[int]:
        return list(self.container.values())