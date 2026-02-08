class Solution:

    def __init__(self, n: int, blacklist: List[int]):
        self.n = n
        self.blacklist = set(blacklist)
        self.mapping = {}
        self.size = n - len(self.blacklist)
        self.last = n - 1
        for b in self.blacklist:
            if b < self.last:
                self.mapping[b] = self.last
                self.last -= 1

    def pick(self) -> int:
        import random
        r = random.randint(0, self.size - 1)
        if r in self.mapping:
            return self.mapping[r]
        return r