class Solution:
    def minimizeXor(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        def count_bits(x):
            return bin(x).count('1')

        nums.sort()
        res = []
        for q in queries:
            idx, val = q
            target = nums[idx]
            bit_count = count_bits(target)
            if bit_count == 0:
                res.append(0)
                continue
            candidate = 0
            for i in range(31, -1, -1):
                if (candidate | (1 << i)) == candidate:
                    continue
                temp = candidate | (1 << i)
                if count_bits(temp) <= bit_count:
                    candidate = temp
            res.append(candidate)
        return res