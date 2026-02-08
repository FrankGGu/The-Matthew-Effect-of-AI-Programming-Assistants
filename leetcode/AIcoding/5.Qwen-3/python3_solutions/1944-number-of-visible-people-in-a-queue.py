class Solution:
    def canSeePersonsAtFrontOfQueue(self, heights: List[int]) -> List[int]:
        n = len(heights)
        res = [0] * n
        stack = []
        for i in range(n):
            while stack and heights[i] > heights[stack[-1]]:
                j = stack.pop()
                res[j] += 1
            if stack:
                res[stack[-1]] += 1
            stack.append(i)
        return res