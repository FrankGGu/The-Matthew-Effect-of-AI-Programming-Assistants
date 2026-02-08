class Solution:
    def largestNumber(self, nums: List[int]) -> int:
        from collections import defaultdict

        even = []
        odd = []

        for num in nums:
            if num % 2 == 0:
                even.append(num)
            else:
                odd.append(num)

        even.sort(reverse=True)
        odd.sort(reverse=True)

        res = []
        i = j = 0

        for num in nums:
            if num % 2 == 0:
                res.append(str(even[i]))
                i += 1
            else:
                res.append(str(odd[j]))
                j += 1

        return int(''.join(res))