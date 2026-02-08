class Solution:

    def __init__(self, w: List[int]):
        self.prefix_sums = []
        current_sum = 0
        for weight in w:
            current_sum += weight
            self.prefix_sums.append(current_sum)

    def pickIndex(self) -> int:
        import random
        target = random.randint(1, self.prefix_sums[-1])
        left, right = 0, len(self.prefix_sums) - 1
        while left < right:
            mid = (left + right) // 2
            if target > self.prefix_sums[mid]:
                left = mid + 1
            else:
                right = mid
        return left