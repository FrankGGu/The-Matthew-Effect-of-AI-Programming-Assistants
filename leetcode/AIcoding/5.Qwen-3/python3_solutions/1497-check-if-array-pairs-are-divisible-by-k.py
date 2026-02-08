class Solution:
    def canDivideArray(self, nums: List[int], k: int) -> bool:
        from collections import defaultdict

        remainder_count = defaultdict(int)

        for num in nums:
            rem = num % k
            if rem == 0:
                if remainder_count[rem] % 2 == 1:
                    return False
                remainder_count[rem] += 1
            else:
                if remainder_count[k - rem] == 0:
                    return False
                remainder_count[k - rem] -= 1
                remainder_count[rem] += 1

        return True