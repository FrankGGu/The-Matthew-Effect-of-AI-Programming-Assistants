class Solution:
    def secondLargest(self, s: str) -> int:
        digits = set()
        for c in s:
            if c.isdigit():
                digits.add(int(c))
        if len(digits) < 2:
            return -1
        sorted_digits = sorted(digits, reverse=True)
        return sorted_digits[1]