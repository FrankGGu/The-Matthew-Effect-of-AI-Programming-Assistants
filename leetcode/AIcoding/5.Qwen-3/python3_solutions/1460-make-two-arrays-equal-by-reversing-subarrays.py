class Solution:
    def canBeEqual(self, target: List[int], theOther: List[int]) -> bool:
        return sorted(target) == sorted(theOther)