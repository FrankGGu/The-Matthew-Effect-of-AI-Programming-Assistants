class Solution:
    def distributeCandies(self, candies: int, num_people: int) -> List[int]:
        result = [0] * num_people
        i = 0
        while candies > 0:
            give = min(i + 1, candies)
            result[i % num_people] += give
            candies -= give
            i += 1
        return result