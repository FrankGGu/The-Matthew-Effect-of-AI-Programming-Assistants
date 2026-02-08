class Solution:
    def poorPigs(self, eggs: int, minutesToTest: int, minutesToDie: int) -> int
        if eggs == 0 or minutesToTest < minutesToDie:
            return 0
        tests = minutesToTest // minutesToDie
        pigs = 0
        while True:
            pigs += 1
            if (tests + 1) ** pigs >= eggs:
                return pigs