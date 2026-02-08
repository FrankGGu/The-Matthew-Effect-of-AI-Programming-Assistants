class Solution:
    def findMissingAndRepeatedValue(self, n: int, m: int, arr: List[int]) -> List[int]:
        xor_all = 0
        for i in range(1, n + 1):
            xor_all ^= i
        xor_arr = 0
        for num in arr:
            xor_arr ^= num
        xor_result = xor_all ^ xor_arr
        mask = xor_result & (-xor_result)
        a, b = 0, 0
        for num in arr:
            if num & mask:
                a ^= num
            else:
                b ^= num
        for i in range(1, n + 1):
            if i & mask:
                a ^= i
            else:
                b ^= i
        if a in arr:
            return [b, a]
        else:
            return [a, b]