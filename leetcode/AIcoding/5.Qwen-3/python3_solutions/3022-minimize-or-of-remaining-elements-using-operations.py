class Solution:
    def minOrAfterOperations(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(30, -1, -1):
            cnt = 0
            temp = res | (1 << i)
            for num in nums:
                if (num & temp) == (res & temp):
                    cnt += 1
            if cnt >= 1:
                res = temp
        return res