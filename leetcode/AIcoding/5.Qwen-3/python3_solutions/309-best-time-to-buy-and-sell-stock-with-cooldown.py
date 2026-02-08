class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices:
            return 0
        n = len(prices)
        hold = [-prices[0]]
        not_hold = [0]
        for i in range(1, n):
            hold.append(max(hold[-1], not_hold[-1] - prices[i]))
            not_hold.append(max(not_hold[-1], hold[-1] + prices[i]))
        return not_hold[-1]