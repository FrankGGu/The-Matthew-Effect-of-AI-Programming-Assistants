class Solution:
    def findString(self, queries: List[Tuple[int, str]], limit: int) -> List[str]:
        from collections import defaultdict

        def lcp(a: str, b: str) -> int:
            min_len = min(len(a), len(b))
            for i in range(min_len):
                if a[i] != b[i]:
                    return i
            return min_len

        result = []
        used = set()
        for q in queries:
            k, s = q
            found = False
            for candidate in used:
                if lcp(candidate, s) >= k:
                    result.append(candidate)
                    found = True
                    break
            if not found:
                for i in range(1 << 10):
                    temp = ""
                    for j in range(limit):
                        temp += chr(ord('a') + (i >> j) % 26)
                    if all(lcp(temp, x) < k for x in used) and all(lcp(temp, x) >= k for x in result if x != temp):
                        result.append(temp)
                        used.add(temp)
                        found = True
                        break
            if not found:
                result.append("".join(chr(ord('a') + (i % 26)) for i in range(limit)))
        return result