class Solution:
    def longestDupSubstring(self, s: str) -> str:
        def search(L):
            base = 26
            mod = 2**64
            hash_val = 0
            for i in range(L):
                hash_val = (hash_val * base + ord(s[i])) % mod
            seen = {hash_val}
            base_L = pow(base, L, mod)
            for i in range(1, len(s) - L + 1):
                hash_val = (hash_val * base - ord(s[i - 1]) * base_L + ord(s[i + L - 1])) % mod
                if hash_val in seen:
                    return i
                seen.add(hash_val)
            return -1

        left, right = 1, len(s) - 1
        result = 0
        while left <= right:
            mid = (left + right) // 2
            idx = search(mid)
            if idx != -1:
                result = idx
                left = mid + 1
            else:
                right = mid - 1
        return s[result:result + (left + right) // 2]