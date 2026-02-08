class Solution:
    def recoverArray(self, deck: List[int]) -> List[int]:
        from collections import Counter

        count = Counter(deck)
        sorted_deck = sorted(deck)
        n = len(deck)
        for i in range(1, n):
            if sorted_deck[i] == sorted_deck[0]:
                continue
            candidate = sorted_deck[i] - sorted_deck[0]
            if candidate == 0:
                continue
            temp = []
            for num in sorted_deck:
                if count[num] == 0:
                    continue
                temp.append(num)
                count[num] -= 1
                if count[num + candidate] == 0:
                    break
                count[num + candidate] -= 1
            if len(temp) == n // 2:
                return temp
            for num in temp:
                count[num] += 1
        return []