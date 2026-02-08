class Solution:
    def describePainting(self, painting: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        color_map = defaultdict(int)
        intervals = []

        for x, y, color in painting:
            intervals.append((x, y, color))

        intervals.sort()

        result = []
        prev_end = -1
        current_color = 0

        for x, y, color in intervals:
            if prev_end < x:
                if current_color > 0:
                    result.append([prev_end, x, current_color])
                current_color = color
            else:
                current_color += color

            prev_end = max(prev_end, y)

        if current_color > 0:
            result.append([prev_end, prev_end, current_color])

        return result