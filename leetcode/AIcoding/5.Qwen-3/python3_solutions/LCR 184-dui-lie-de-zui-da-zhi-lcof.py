class Cashier:
    def __init__(self, n: int, k: int):
        self.n = n
        self.k = k
        self.count = 0

    def getBill(self, products: list[int], amounts: list[int]) -> float:
        self.count += 1
        total = 0.0
        for p, a in zip(products, amounts):
            total += p * a
        if self.count % self.k == 0:
            return total * 0.9
        return total