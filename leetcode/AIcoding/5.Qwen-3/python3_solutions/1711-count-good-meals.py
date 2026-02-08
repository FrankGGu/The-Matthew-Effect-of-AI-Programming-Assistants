class Solution:
    def countPairs(self, deliciousness: List[int]) -> int:
        from collections import defaultdict

        mod = 10**9 + 7
        max_val = max(deliciousness) if deliciousness else 0
        power_of_two = set()
        for i in range(21):
            power_of_two.add(2 ** i)

        count = 0
        seen = defaultdict(int)

        for num in deliciousness:
            for p in power_of_two:
                if (p - num) in seen:
                    count += seen[p - num]
            seen[num] += 1

        return count % mod