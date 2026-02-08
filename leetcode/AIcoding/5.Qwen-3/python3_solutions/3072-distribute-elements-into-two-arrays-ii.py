class Solution:
    def distributeElements(self, nums: List[int]) -> List[List[int]]:
        from collections import defaultdict

        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        res = [[], []]
        for num in sorted(count.keys()):
            cnt = count[num]
            if cnt % 2 == 0:
                res[0].extend([num] * (cnt // 2))
                res[1].extend([num] * (cnt // 2))
            else:
                res[0].append(num)
                res[1].extend([num] * (cnt - 1))

        return res