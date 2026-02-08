class Solution:
    def largestTimeFromDigits(self, A: List[int]) -> str:
        from itertools import permutations

        max_time = -1
        for p in permutations(A):
            hour = p[0] * 10 + p[1]
            minute = p[2] * 10 + p[3]
            if 0 <= hour < 24 and 0 <= minute < 60:
                total_minutes = hour * 60 + minute
                if total_minutes > max_time:
                    max_time = total_minutes

        if max_time == -1:
            return ""
        else:
            hour = max_time // 60
            minute = max_time % 60
            return f"{hour:02d}:{minute:02d}"