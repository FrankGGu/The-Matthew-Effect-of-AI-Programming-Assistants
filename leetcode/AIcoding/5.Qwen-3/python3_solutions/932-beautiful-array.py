class Solution:
    def beautifulArray(self, n: int) -> List[int]:
        res = []
        def f(n):
            if n == 1:
                return [1]
            odd = f((n + 1) // 2)
            even = f(n // 2)
            return [i * 2 - 1 for i in odd] + [i * 2 for i in even]
        return f(n)