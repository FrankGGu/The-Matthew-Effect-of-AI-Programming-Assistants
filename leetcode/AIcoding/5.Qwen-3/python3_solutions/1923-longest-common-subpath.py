class Solution:
    def longestCommonSubpath(self, n: int, paths: List[List[int]]) -> int:
        from collections import defaultdict

        def build_prefix_hash(path, base, mod):
            m = len(path)
            hash_val = 0
            power = 1
            prefix = [0] * (m + 1)
            for i in range(m):
                hash_val = (hash_val * base + path[i]) % mod
                prefix[i + 1] = hash_val
                power = (power * base) % mod
            return prefix, power

        def get_subpath_hash(prefix, power, start, end, mod):
            return (prefix[end] - prefix[start] * power) % mod

        def check(length):
            if length == 0:
                return True
            seen = set()
            for path in paths:
                m = len(path)
                if m < length:
                    return False
                prefix, power = build_prefix_hash(path, 257, 10**9 + 7)
                current_hashes = set()
                for i in range(len(path) - length + 1):
                    h = get_subpath_hash(prefix, power, i, i + length, 10**9 + 7)
                    current_hashes.add(h)
                if not current_hashes:
                    return False
                if not seen:
                    seen = current_hashes
                else:
                    seen &= current_hashes
                    if not seen:
                        return False
            return bool(seen)

        left, right = 0, min(len(p) for p in paths)
        result = 0
        while left <= right:
            mid = (left + right) // 2
            if check(mid):
                result = mid
                left = mid + 1
            else:
                right = mid - 1
        return result