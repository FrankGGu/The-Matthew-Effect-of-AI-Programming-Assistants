class Solution:
    def differenceBetweenTwoStrings(self, target: str, start: str) -> int:
        from collections import Counter

        target_count = Counter(target)
        start_count = Counter(start)

        diff = 0
        for char in target_count:
            if char in start_count:
                diff += max(0, target_count[char] - start_count[char])
            else:
                diff += target_count[char]

        return diff