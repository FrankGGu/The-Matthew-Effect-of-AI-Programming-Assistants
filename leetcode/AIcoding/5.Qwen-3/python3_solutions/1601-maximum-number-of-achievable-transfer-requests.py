class Solution:
    def maximumRequests(self, n: int, requests: List[List[int]]) -> int:
        from itertools import combinations

        def check(mask):
            balance = [0] * n
            for i in range(len(requests)):
                if mask & (1 << i):
                    u, v = requests[i]
                    balance[u] -= 1
                    balance[v] += 1
            return all(b == 0 for b in balance)

        m = len(requests)
        for k in range(m, 0, -1):
            for bits in combinations(range(m), k):
                mask = 0
                for b in bits:
                    mask |= (1 << b)
                if check(mask):
                    return k
        return 0