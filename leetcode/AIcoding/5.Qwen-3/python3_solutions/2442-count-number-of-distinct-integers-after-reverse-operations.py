class Solution:
    def countDistinctIntegers(self, nums: List[int]) -> int:
        s = set()
        for num in nums:
            s.add(num)
            rev = int(str(num)[::-1])
            s.add(rev)
        return len(s)