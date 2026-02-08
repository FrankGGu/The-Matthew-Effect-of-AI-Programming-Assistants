class Solution:
    def __init__(self):
        self.mod = 10**9 + 7
        self.pow2 = [1] * (10**5 + 1)
        for i in range(1, 10**5 + 1):
            self.pow2[i] = (self.pow2[i - 1] * 2) % self.mod

    def num(self, left, right):
        return (self.pow2[right] * pow(self.pow2[left], self.mod - 2, self.mod)) % self.mod

    def findProductsOfElements(self, queries, n):
        res = []
        for l, r in queries:
            res.append(self.num(l, r))
        return res