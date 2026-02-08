class Solution:
    def isThree(self, n: int) -> bool:
        if n < 2:
            return False
        count = 0
        for i in range(1, int(n**0.5) + 1):
            if n % i == 0:
                count += 1
                if i != n // i:
                    count += 1
        return count == 3