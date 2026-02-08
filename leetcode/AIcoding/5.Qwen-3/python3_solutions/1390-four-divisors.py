class Solution:
    def sumOfDivisors(self, nums: List[int]) -> List[int]:
        def getDivisorsSum(n):
            divisors = set()
            for i in range(1, int(n**0.5) + 1):
                if n % i == 0:
                    divisors.add(i)
                    divisors.add(n // i)
            if len(divisors) == 4:
                return sum(divisors)
            else:
                return 0

        result = []
        for num in nums:
            result.append(getDivisorsSum(num))
        return result