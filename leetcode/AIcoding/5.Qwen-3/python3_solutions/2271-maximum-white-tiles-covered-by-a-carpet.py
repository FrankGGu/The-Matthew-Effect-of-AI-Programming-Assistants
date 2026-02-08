class Solution:
    def maximumWhiteTiles(self, carpet: List[List[int]], k: int) -> int:
        events = []
        for start, end in carpet:
            events.append((start, 1))
            events.append((end + 1, -1))

        events.sort()

        res = 0
        count = 0
        prev = 0
        for time, delta in events:
            if prev < time:
                if prev + k >= time:
                    res = max(res, count * (time - prev))
                else:
                    res = max(res, count * (k - (prev - 0)))
            count += delta
            prev = time

        return res