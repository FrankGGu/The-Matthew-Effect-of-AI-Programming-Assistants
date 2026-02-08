class Solution:
    def minimumCoins(self, coins: List[int], neededSum: int) -> int:
        coins.sort(reverse=True)
        res = 0
        current = 0
        for coin in coins:
            if current >= neededSum:
                break
            if coin > neededSum:
                continue
            count = (neededSum - current + coin - 1) // coin
            res += count
            current += count * coin
        return res if current >= neededSum else -1