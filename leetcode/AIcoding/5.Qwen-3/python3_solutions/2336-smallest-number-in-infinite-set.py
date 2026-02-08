class SmallestInfiniteSet:
    def __init__(self):
        self.current = 1
        self.used = set()

    def pop_smallest(self):
        if self.used:
            min_val = min(self.used)
            self.used.remove(min_val)
            return min_val
        else:
            self.current += 1
            return self.current - 1

    def add_back(self, num):
        if num < self.current:
            self.used.add(num)