class Solution:
    def countRepetitions(self, s: str, k: int, n: int) -> int:
        from collections import defaultdict

        def get_count(s, k):
            count = 0
            for c in s:
                if c == k:
                    count += 1
            return count

        def get_index(s, k):
            index = []
            for i, c in enumerate(s):
                if c == k:
                    index.append(i)
            return index

        if n == 0:
            return 0

        index_map = defaultdict(list)
        for i, c in enumerate(s):
            index_map[c].append(i)

        result = 0
        current = 0
        while True:
            found = False
            for c in index_map:
                if len(index_map[c]) > 0 and index_map[c][0] >= current:
                    next_pos = index_map[c][0]
                    if next_pos < current:
                        continue
                    if next_pos + len(s) <= n:
                        result += 1
                        current = next_pos + len(s)
                        found = True
                        break
            if not found:
                break

        return result