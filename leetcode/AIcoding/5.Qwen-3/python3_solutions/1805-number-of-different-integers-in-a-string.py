class Solution:
    def numberDifferentIntegers(self, s: str) -> int:
        nums = set()
        i = 0
        while i < len(s):
            if s[i].isdigit():
                j = i
                while j < len(s) and s[j].isdigit():
                    j += 1
                nums.add(s[i:j])
                i = j
            else:
                i += 1
        return len(nums)