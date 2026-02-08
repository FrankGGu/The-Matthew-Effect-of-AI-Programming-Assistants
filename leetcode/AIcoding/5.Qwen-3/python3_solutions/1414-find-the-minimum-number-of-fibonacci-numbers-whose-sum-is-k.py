class Solution:
    def findMinFibonacciNumbers(self, k: int) -> int:
        fib = [1, 1]
        while fib[-1] + fib[-2] <= k:
            fib.append(fib[-1] + fib[-2])
        res = 0
        i = len(fib) - 1
        while k > 0:
            if fib[i] <= k:
                k -= fib[i]
                res += 1
            i -= 1
        return res