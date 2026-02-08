class Solution:
    def minCoins(self, fruits: List[str], coins: List[int]) -> int:
        from collections import defaultdict

        fruit_map = defaultdict(int)
        for fruit in fruits:
            fruit_map[fruit] += 1

        coin_dict = {}
        for i in range(len(coins)):
            coin_dict[i] = coins[i]

        total = 0
        for fruit, count in fruit_map.items():
            if fruit == 'apple':
                total += count * coin_dict[0]
            elif fruit == 'banana':
                total += count * coin_dict[1]
            elif fruit == 'orange':
                total += count * coin_dict[2]
            elif fruit == 'grape':
                total += count * coin_dict[3]
            elif fruit == 'watermelon':
                total += count * coin_dict[4]

        return total