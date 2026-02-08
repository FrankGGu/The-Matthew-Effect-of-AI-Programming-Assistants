class Solution:
    def differentSubsequenceGCDs(self, nums):
        max_num = max(nums)
        seen = set(nums)
        result = 0
        for i in range(1, max_num + 1):
            g = 0
            for j in range(i, max_num + 1, i):
                if j in seen:
                    g = gcd(g, j)
            if g == i:
                result += 1
        return result

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a