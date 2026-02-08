class Solution:
    def bestHand(self, ranks: List[int], suits: List[int]) -> str:
        if len(set(suits)) == 1:
            return "Flush"
        count = {}
        for r in ranks:
            count[r] = count.get(r, 0) + 1
        max_count = max(count.values())
        if max_count >= 4:
            return "Four of a Kind"
        elif max_count == 3:
            return "Three of a Kind"
        elif max_count == 2:
            return "Pair"
        else:
            return "High Card"