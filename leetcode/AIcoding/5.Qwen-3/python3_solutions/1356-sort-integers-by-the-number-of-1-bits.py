class Solution:
    def sort_by_bit(self, x):
        return bin(x).count('1'), x

    def sortByBits(self, arr: List[int]) -> List[int]:
        return sorted(arr, key=self.sort_by_bit)