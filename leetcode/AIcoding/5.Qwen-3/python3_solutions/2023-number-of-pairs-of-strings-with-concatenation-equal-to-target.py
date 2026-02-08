class Solution:
    def numberOfPairs(self, nums: List[str]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        result = 0

        for num in nums:
            count[num] += 1

        for key in count:
            if key in count:
                if key * 2 in count:
                    if key == key * 2:
                        result += count[key] * (count[key] - 1) // 2
                    else:
                        result += count[key] * count[key * 2]
                        del count[key * 2]

        return result