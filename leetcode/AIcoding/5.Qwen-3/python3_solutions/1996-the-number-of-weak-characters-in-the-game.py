class Solution:
    def numberOfWeakCharacters(self, nums: List[List[int]]) -> int:
        nums.sort(key=lambda x: (x[0], x[1]))
        count = 0
        max_defense = 0
        for a, d in nums:
            if d < max_defense:
                count += 1
            else:
                max_defense = d
        return count