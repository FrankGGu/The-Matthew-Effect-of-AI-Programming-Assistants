from collections import Counter

class Solution:
    def canReorderArray(self, arr: list[int]) -> bool:
        count = Counter(arr)
        for num in sorted(count):
            if count[num] == 0:
                continue
            if num == 0:
                if count[num] % 2 != 0:
                    return False
            else:
                if count[2 * num] < count[num]:
                    return False
                count[2 * num] -= count[num]
        return True