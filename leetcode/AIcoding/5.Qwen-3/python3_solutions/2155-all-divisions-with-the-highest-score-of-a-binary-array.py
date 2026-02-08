from typing import List

class Solution:
    def highScores(self, grades: List[int]) -> List[int]:
        total = len(grades)
        zero_count = 0
        one_count = sum(1 for g in grades if g == 1)
        max_score = 0
        result = []

        for i in range(total + 1):
            score = zero_count + (one_count - (i - zero_count))
            if score > max_score:
                max_score = score
                result = [i]
            elif score == max_score:
                result.append(i)
            if i < total:
                if grades[i] == 0:
                    zero_count += 1
                else:
                    one_count -= 1

        return result