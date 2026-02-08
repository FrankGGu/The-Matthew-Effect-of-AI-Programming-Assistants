class CombinationIterator:
    def __init__(self, characters: str, n: int):
        self.characters = characters
        self.n = n
        self.indexes = list(range(n))
        self.has_next = True

    def next(self) -> str:
        result = ''.join(self.characters[i] for i in self.indexes)
        i = self.n - 1
        while i >= 0 and self.indexes[i] == len(self.characters) - 1 - (self.n - 1 - i):
            i -= 1
        if i < 0:
            self.has_next = False
            return result
        self.indexes[i] += 1
        for j in range(i + 1, self.n):
            self.indexes[j] = self.indexes[j - 1] + 1
        return result

    def hasNext(self) -> bool:
        return self.has_next