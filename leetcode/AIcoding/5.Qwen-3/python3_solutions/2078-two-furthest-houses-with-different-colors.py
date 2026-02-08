class Solution:
    def maxDistance(self, colors: List[int]) -> int:
        n = len(colors)
        left = 0
        right = n - 1
        while colors[left] == colors[right] and left < right:
            if colors[left] == colors[0]:
                left += 1
            else:
                right -= 1
        if left == right:
            return 0
        return max(right, n - 1 - left)