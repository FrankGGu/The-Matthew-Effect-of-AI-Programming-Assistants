class Fancy:
    def __init__(self):
        self.seq = []
        self.add = 0
        self.mul = 1

    def append(self, val: int) -> None:
        self.seq.append(val - self.add)
        self.add = 0
        self.mul = 1

    def addAll(self, inc: int) -> None:
        self.add += inc

    def multAll(self, m: int) -> None:
        self.mul *= m
        self.add *= m

    def getIndex(self, i: int) -> int:
        if i >= len(self.seq):
            return -1
        res = self.seq[i] * self.mul + self.add
        return res