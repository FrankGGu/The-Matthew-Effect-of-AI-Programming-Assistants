class Solution:
    def maximumSumQueries(self, nums1: List[int], nums2: List[int], queries: List[int]) -> List[int]:
        from collections import defaultdict

        n = len(nums1)
        pairs = [(nums1[i], nums2[i]) for i in range(n)]
        sorted_pairs = sorted(pairs, key=lambda x: x[0])
        max_sum = [0] * n
        stack = []

        for i in range(n - 1, -1, -1):
            num1, num2 = sorted_pairs[i]
            while stack and stack[-1][1] <= num2:
                stack.pop()
            if not stack:
                max_sum[i] = -1
            else:
                max_sum[i] = stack[-1][0] + num2
            stack.append((num1, num2))

        result = []
        for q in queries:
            found = -1
            for i in range(n):
                if sorted_pairs[i][0] >= q:
                    found = max_sum[i]
                    break
            result.append(found)
        return result