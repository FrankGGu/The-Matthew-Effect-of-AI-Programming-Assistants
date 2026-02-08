class Solution:
    def __init__(self, nums: List[int], k: int):
        self.nums = nums
        self.k = k
        self.count = defaultdict(int)
        self.window = deque()
        for i in range(k):
            self.window.append(nums[i])
            self.count[nums[i]] += 1

    def consec(self) -> bool:
        if len(self.window) < self.k:
            return False
        for num in self.count:
            if self.count[num] == self.k:
                return True
        return False

    def next(self, num: int) -> bool:
        self.window.append(num)
        self.count[num] += 1
        if len(self.window) > self.k:
            left = self.window.popleft()
            self.count[left] -= 1
            if self.count[left] == 0:
                del self.count[left]
        return self.consec()