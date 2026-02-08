class Solution:
    def sortEvenOdd(self, nums: List[int]) -> List[int]:
        even = []
        odd = []
        for i in range(len(nums)):
            if i % 2 == 0:
                even.append(nums[i])
            else:
                odd.append(nums[i])
        even.sort()
        odd.sort(reverse=True)
        res = []
        e = o = 0
        for i in range(len(nums)):
            if i % 2 == 0:
                res.append(even[e])
                e += 1
            else:
                res.append(odd[o])
                o += 1
        return res