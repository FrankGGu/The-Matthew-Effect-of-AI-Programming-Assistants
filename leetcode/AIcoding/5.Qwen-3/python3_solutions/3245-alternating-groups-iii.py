class Solution:
    def numberOfAlternatingGroups(self, colors: List[int], k: int) -> int:
        n = len(colors)
        colors += colors[:k-1]
        count = 0
        for i in range(n):
            if colors[i] != colors[i+1] and colors[i+1] != colors[i+2] and colors[i] != colors[i+2]:
                count += 1
        return count