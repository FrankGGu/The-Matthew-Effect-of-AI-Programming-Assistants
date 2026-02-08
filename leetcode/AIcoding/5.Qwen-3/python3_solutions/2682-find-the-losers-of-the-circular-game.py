class Solution:
    def findWinners(self, matches: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        winners = defaultdict(int)
        losers = defaultdict(int)

        for winner, loser in matches:
            winners[winner] += 1
            losers[loser] += 1

        zero_loses = [player for player in winners if losers[player] == 0]
        one_lose = [player for player in losers if losers[player] == 1]

        return [sorted(zero_loses), sorted(one_lose)]