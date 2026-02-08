class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        positive = []
        negative = []
        for num in nums:
            if num > 0:
                positive.append(num)
            else:
                negative.append(num)
        result = []
        for p, n in zip(positive, negative):
            result.append(p)
            result.append(n)
        return result