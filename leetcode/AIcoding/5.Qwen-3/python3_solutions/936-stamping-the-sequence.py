class Solution:
    def possibleToStamp(self, target: str, original: str, stamped: str) -> bool:
        from collections import deque

        def build_failure_array(pattern):
            n = len(pattern)
            fail = [0] * n
            j = 0
            for i in range(1, n):
                while j > 0 and pattern[i] != pattern[j]:
                    j = fail[j - 1]
                if pattern[i] == pattern[j]:
                    j += 1
                    fail[i] = j
                else:
                    fail[i] = 0
            return fail

        def kmp_search(text, pattern, fail):
            n = len(text)
            m = len(pattern)
            j = 0
            result = []
            for i in range(n):
                while j > 0 and text[i] != pattern[j]:
                    j = fail[j - 1]
                if text[i] == pattern[j]:
                    j += 1
                if j == m:
                    result.append(i - m + 1)
                    j = fail[j - 1]
            return result

        target_len = len(target)
        original_len = len(original)
        stamped_len = len(stamped)

        if stamped_len > original_len:
            return False

        fail = build_failure_array(stamped)
        positions = kmp_search(original, stamped, fail)

        if not positions:
            return False

        stamp_positions = set(positions)
        stamp_positions = sorted(stamp_positions)

        for i in range(len(stamp_positions)):
            start = stamp_positions[i]
            end = start + stamped_len
            for j in range(i + 1, len(stamp_positions)):
                next_start = stamp_positions[j]
                if next_start >= end:
                    break
                if next_start + stamped_len > end:
                    return False

        for i in range(target_len):
            found = False
            for pos in stamp_positions:
                if pos <= i < pos + stamped_len:
                    found = True
                    break
            if not found and target[i] != original[i]:
                return False

        return True