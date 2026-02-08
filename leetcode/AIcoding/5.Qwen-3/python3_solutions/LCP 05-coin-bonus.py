class Solution:
    def coinBonus(self, coins: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for coin in coins:
            count[coin] += 1

        bonus = 0
        for key in count:
            if count[key] >= 2:
                bonus += 1

        return bonus