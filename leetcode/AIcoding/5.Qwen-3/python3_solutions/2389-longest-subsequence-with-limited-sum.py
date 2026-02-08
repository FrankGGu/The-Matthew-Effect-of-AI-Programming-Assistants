class Solution:
    def answerQueries(self, nums: List[int], queries: List[int]) -> List[int]:
        nums.sort()
        res = []
        for q in queries:
            count = 0
            total = 0
            for num in nums:
                if total + num <= q:
                    total += num
                    count += 1
                else:
                    break
            res.append(count)
        return res