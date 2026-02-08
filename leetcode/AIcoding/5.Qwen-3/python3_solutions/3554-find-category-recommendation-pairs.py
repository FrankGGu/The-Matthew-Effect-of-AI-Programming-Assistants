class Solution:
    def findCategoryRecommendationPairs(self, categories: List[int], k: int) -> List[List[int]]:
        from collections import defaultdict

        count = defaultdict(int)
        result = []

        for i in range(len(categories)):
            category = categories[i]
            if count[category] >= k:
                continue
            count[category] += 1
            for j in range(i + 1, len(categories)):
                if categories[j] == category and count[categories[j]] < k:
                    result.append([i, j])
                    count[categories[j]] += 1
                    break

        return result