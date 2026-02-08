class NumArray:
    def __init__(self, nums):
        self.n = len(nums)
        self.tree = [0] * (self.n + 1)
        for i in range(self.n):
            self.update(i, nums[i])

    def update(self, index, value):
        index += 1
        while index <= self.n:
            self.tree[index] += value
            index += index & -index

    def sumRange(self, left, right):
        def query(index):
            index += 1
            res = 0
            while index > 0:
                res += self.tree[index]
                index -= index & -index
            return res
        return query(right) - query(left - 1)