class Solution:
    def getMaximumConsecutive(self, coins: List[int]) -> int:
        coins.sort()
        res = 0
        for coin in coins:
            if coin <= res + 1:
                res += coin
            else:
                break
        return res + 1