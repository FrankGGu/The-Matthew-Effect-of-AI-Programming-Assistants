class Solution:
    def subarrayBitwiseORS(self, nums: List[int]) -> int:
        result = set()
        current = set()
        for num in nums:
            new_current = {num}
            for x in current:
                new_current.add(x | num)
            current = new_current
            result.update(current)
        return len(result)