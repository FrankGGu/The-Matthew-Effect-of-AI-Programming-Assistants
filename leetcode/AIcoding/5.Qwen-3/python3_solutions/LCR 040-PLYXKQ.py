class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        if not matrix:
            return 0
        max_area = 0
        heights = [0] * len(matrix[0])
        for row in matrix:
            for i in range(len(row)):
                if row[i] == '1':
                    heights[i] += 1
                else:
                    heights[i] = 0
            stack = []
            for i in range(len(heights) + 1):
                h = heights[i] if i < len(heights) else 0
                while stack and heights[stack[-1]] > h:
                    height = heights[stack.pop()]
                    width = i if not stack else i - stack[-1] - 1
                    max_area = max(max_area, height * width)
                stack.append(i)
        return max_area