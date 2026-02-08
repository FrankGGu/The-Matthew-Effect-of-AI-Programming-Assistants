class Solution:
    def buyChocolates(self, prices: List[int], money: int) -> int:
        prices.sort()
        return money - prices[0] - prices[1]