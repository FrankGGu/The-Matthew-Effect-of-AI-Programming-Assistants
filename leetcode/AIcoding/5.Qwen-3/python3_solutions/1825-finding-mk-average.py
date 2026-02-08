class MKAverage:

    def __init__(self, m: int, k: int):
        self.m = m
        self.k = k
        self.n = 0
        self.data = []
        self.sorted_data = []
        self.total = 0
        self.middle_sum = 0
        self.left = []
        self.right = []
        self.middle = []

    def addElement(self, num: int) -> None:
        self.data.append(num)
        self.n += 1
        self.sorted_data.append(num)
        self.sorted_data.sort()
        if self.n > self.m:
            removed = self.data[self.n - self.m - 1]
            self.sorted_data.remove(removed)
        if self.n >= self.m:
            self.middle_sum = sum(self.sorted_data[self.k:-self.k])
            self.total = self.middle_sum

    def calculateMKAverage(self) -> int:
        return self.total // self.m