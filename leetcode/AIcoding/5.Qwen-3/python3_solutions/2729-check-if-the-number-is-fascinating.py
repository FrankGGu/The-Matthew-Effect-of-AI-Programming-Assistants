class Solution:
    def isFascinating(self, number: int) -> bool:
        s = str(number)
        if len(s) != 3:
            return False
        s += str(number * 2) + str(number * 3)
        return len(s) == 9 and set(s) == set('123456789')