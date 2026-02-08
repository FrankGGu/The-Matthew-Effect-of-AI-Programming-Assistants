class Solution:
    def isRearrangeToTarget(self, s: str, target: str, k: int) -> bool:
        from collections import Counter

        if len(s) < len(target):
            return False

        count = Counter(s)
        target_count = Counter(target)

        for char in target_count:
            if count[char] < target_count[char]:
                return False

        return True