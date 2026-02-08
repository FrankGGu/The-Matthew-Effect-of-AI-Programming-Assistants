class Solution:
    def numRabbits(self, answers: List[int]) -> int:
        from collections import Counter

        count = Counter()
        total = 0

        for ans in answers:
            if count[ans] == 0:
                total += ans + 1
                count[ans] += 1
            else:
                count[ans] += 1
                if count[ans] > ans:
                    count[ans] = 0

        return total