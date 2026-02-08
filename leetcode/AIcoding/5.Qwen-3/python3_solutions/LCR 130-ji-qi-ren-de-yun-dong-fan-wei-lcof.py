class Solution:
    def arrangeClothes(self, clothes: List[str]) -> List[str]:
        from collections import defaultdict

        count = defaultdict(int)
        for cloth in clothes:
            count[cloth] += 1

        result = []
        for key in count:
            result.extend([key] * count[key])

        return result