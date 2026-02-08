class Solution:
    def distinctNames(self, ideas: List[str]) -> int:
        from collections import defaultdict

        suffix_map = defaultdict(set)
        for idea in ideas:
            suffix_map[idea[0]].add(idea[1:])

        result = 0
        keys = list(suffix_map.keys())
        for i in range(len(keys)):
            for j in range(i + 1, len(keys)):
                a, b = keys[i], keys[j]
                common = suffix_map[a] & suffix_map[b]
                count_a = len(suffix_map[a] - common)
                count_b = len(suffix_map[b] - common)
                result += count_a * count_b * 2

        return result