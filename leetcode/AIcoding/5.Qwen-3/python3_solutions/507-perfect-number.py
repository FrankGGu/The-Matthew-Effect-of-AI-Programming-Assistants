class Solution:
    def checkPerfectNumber(self, num: int) -> bool:
        if num <= 1:
            return False
        sum_divisors = 1
        sqrt_num = int(num ** 0.5)
        for i in range(2, sqrt_num + 1):
            if num % i == 0:
                sum_divisors += i
                other_divisor = num // i
                if other_divisor != i:
                    sum_divisors += other_divisor
        return sum_divisors == num