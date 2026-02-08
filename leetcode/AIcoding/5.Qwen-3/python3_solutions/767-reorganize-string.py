from collections import Counter
import heapq

class Solution:
    def reorganizeString(self, s: str) -> str:
        count = Counter(s)
        max_freq = max(count.values())
        if max_freq > (len(s) + 1) // 2:
            return ""

        heap = []
        for char, freq in count.items():
            heapq.heappush(heap, (-freq, char))

        result = []
        prev_freq, prev_char = 0, ""

        while heap or prev_freq < 0:
            if prev_freq < 0:
                heapq.heappush(heap, (prev_freq, prev_char))
            curr_freq, curr_char = heapq.heappop(heap)
            result.append(curr_char)
            prev_freq, prev_char = curr_freq + 1, curr_char

        return "".join(result)