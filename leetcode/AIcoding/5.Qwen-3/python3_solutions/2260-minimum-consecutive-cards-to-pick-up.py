class Solution:
    def minimumCardPick(self, cards: List[int]) -> int:
        last_index = {}
        min_length = float('inf')
        for i, card in enumerate(cards):
            if card in last_index:
                min_length = min(min_length, i - last_index[card] + 1)
            last_index[card] = i
        return min_length if min_length != float('inf') else -1