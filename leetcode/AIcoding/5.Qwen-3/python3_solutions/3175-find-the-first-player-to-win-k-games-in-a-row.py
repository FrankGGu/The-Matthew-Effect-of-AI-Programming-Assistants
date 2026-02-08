class Solution:
    def kGamesInARow(self, score: List[int], k: int) -> int:
        count = 0
        for i in range(len(score)):
            if i == 0 or score[i] > score[i - 1]:
                count = 1
            else:
                count += 1
            if count >= k:
                return i
        return -1