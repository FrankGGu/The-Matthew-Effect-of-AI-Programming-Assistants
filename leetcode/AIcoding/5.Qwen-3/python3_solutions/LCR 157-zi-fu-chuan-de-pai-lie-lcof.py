class Solution:
    def getNumberOfBacklogCards(self, orders: List[List[int]]) -> int:
        import heapq
        buy = []
        sell = []
        for price, amount in orders:
            if price <= 0:
                continue
            if amount == 0:
                continue
            if price > 0:
                while amount > 0 and sell and sell[0][0] <= price:
                    s_price, s_amount = heapq.heappop(sell)
                    if s_amount > amount:
                        heapq.heappush(sell, (s_price, s_amount - amount))
                        amount = 0
                        break
                    else:
                        amount -= s_amount
                if amount > 0:
                    heapq.heappush(buy, (-price, amount))
            else:
                while amount > 0 and buy and -buy[0][0] >= price:
                    b_price, b_amount = heapq.heappop(buy)
                    if b_amount > amount:
                        heapq.heappush(buy, (b_price, b_amount - amount))
                        amount = 0
                        break
                    else:
                        amount -= b_amount
                if amount > 0:
                    heapq.heappush(sell, (price, amount))
        total = 0
        while buy:
            total += heapq.heappop(buy)[1]
        while sell:
            total += heapq.heappop(sell)[1]
        return total % (10**9 + 7)