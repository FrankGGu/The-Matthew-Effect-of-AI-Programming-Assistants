class Solution:
    def smallestRepunitDivByK(self, k: int) -> int:
        seen = set()
        remainder = 1 % k
        length = 1
        while remainder not in seen:
            if remainder == 0:
                return length
            seen.add(remainder)
            remainder = (remainder * 10 + 1) % k
            length += 1
        return -1