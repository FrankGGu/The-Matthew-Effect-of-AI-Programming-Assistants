class Solution:
    def nthSuperUglyNumber(self, n: int, primes: List[int]) -> int:
        import heapq
        ugly = [1]
        seen = {1}
        heap = [(p, p, 0) for p in primes]

        while len(ugly) < n:
            val, prime, index = heapq.heappop(heap)
            if val not in seen:
                seen.add(val)
                ugly.append(val)
            next_index = index + 1
            next_val = primes[next_index] * val
            heapq.heappush(heap, (next_val, primes[next_index], next_index))

        return ugly[-1]