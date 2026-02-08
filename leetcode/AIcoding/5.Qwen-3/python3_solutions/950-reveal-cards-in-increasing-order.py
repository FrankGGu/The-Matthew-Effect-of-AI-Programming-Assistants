from collections import deque
from typing import List

class Solution:
    def deckRevealedInOrder(self, deck: List[int]) -> List[int]:
        n = len(deck)
        index = deque(range(n))
        result = [0] * n
        deck.sort()
        for card in deck:
            i = index.popleft()
            result[i] = card
            if index:
                index.append(index.popleft())
        return result