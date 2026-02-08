class Solution:
    def numFriendRequests(self, ages: List[int]) -> int:
        from collections import Counter

        count = Counter(ages)
        res = 0
        for age1 in count:
            for age2 in count:
                if age1 > 12 and age1 <= 0.5 * age2 + 7:
                    continue
                if age1 < age2:
                    continue
                res += count[age1] * count[age2]
        return res