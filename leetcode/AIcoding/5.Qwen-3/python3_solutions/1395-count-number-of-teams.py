class Solution:
    def numTeams(self, rating) -> int:
        n = len(rating)
        total = 0
        for i in range(n):
            left_less = 0
            left_more = 0
            right_less = 0
            right_more = 0
            for j in range(i):
                if rating[j] < rating[i]:
                    left_less += 1
                elif rating[j] > rating[i]:
                    left_more += 1
            for j in range(i + 1, n):
                if rating[j] < rating[i]:
                    right_less += 1
                elif rating[j] > rating[i]:
                    right_more += 1
            total += left_less * right_more + left_more * right_less
        return total