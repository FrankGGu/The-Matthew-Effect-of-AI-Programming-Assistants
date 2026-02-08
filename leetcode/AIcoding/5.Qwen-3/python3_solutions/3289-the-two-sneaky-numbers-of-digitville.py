class Solution:
    def twoSneakyNumbers(self, nums: List[int]) -> List[int]:
        freq = [0] * 100
        for num in nums:
            freq[num] += 1
        result = []
        for i in range(100):
            if freq[i] == 2:
                result.append(i)
        return result