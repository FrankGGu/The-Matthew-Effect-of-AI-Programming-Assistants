class Solution:
    def closestDivisors(self, num: int) -> List[int]:
        def findClosest(n):
            for i in range(int(n**0.5), 0, -1):
                if n % i == 0:
                    return [i, n // i]
            return [1, n]

        a = findClosest(num + 1)
        b = findClosest(num + 2)
        return a if abs(a[0] - a[1]) < abs(b[0] - b[1]) else b