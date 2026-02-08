class Solution:
    def minimumSwaps(self, nums: List[int]) -> int:
        def digit_sum(n):
            s = 0
            while n:
                s += n % 10
                n //= 10
            return s

        pairs = [(digit_sum(num), i) for i, num in enumerate(nums)]
        sorted_pairs = sorted(pairs)
        visited = [False] * len(nums)
        result = 0

        for i in range(len(nums)):
            if visited[i]:
                continue
            cycle_size = 0
            j = i
            while not visited[j]:
                visited[j] = True
                j = sorted_pairs.index(pairs[j])
                cycle_size += 1
            if cycle_size > 1:
                result += (cycle_size - 1)

        return result