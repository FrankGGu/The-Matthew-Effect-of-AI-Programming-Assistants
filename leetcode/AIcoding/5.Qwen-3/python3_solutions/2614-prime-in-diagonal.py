class Solution:
    def diagonalPrime(self, nums: List[List[int]]) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        max_val = 0
        n = len(nums)
        for i in range(n):
            if is_prime(nums[i][i]):
                max_val = max(max_val, nums[i][i])
            if is_prime(nums[i][n - i - 1]):
                max_val = max(max_val, nums[i][n - i - 1])
        return max_val