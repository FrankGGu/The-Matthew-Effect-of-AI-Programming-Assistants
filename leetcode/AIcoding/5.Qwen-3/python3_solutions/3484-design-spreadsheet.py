class Spreadsheet:
    def __init__(self):
        self.cells = {}

    def set(self, r: int, c: int, v: str) -> None:
        self.cells[(r, c)] = v

    def get(self, r: int, c: int) -> str:
        return self.cells.get((r, c), "")

    def range(self, r1: int, c1: int, r2: int, c2: int) -> list[str]:
        result = []
        for r in range(r1, r2 + 1):
            for c in range(c1, c2 + 1):
                result.append(self.get(r, c))
        return result