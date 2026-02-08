class Solution:
    def nearestPalindromes(self, n: str) -> str:
        length = len(n)
        candidates = set()

        # Palindromes with one digit less
        if length > 1:
            candidates.add(10 ** (length - 1) - 1)

        # Palindromes with same number of digits
        prefix = int(n[:(length + 1) // 2])
        for p in [prefix - 1, prefix, prefix + 1]:
            if length % 2 == 0:
                candidate = int(str(p) + str(p)[::-1])
            else:
                candidate = int(str(p) + str(p)[:-1][::-1])
            candidates.add(candidate)

        # Palindromes with one digit more
        if length > 1:
            candidates.add(10 ** length + 1)

        # Remove the original number if it's a palindrome
        original = int(n)
        candidates.discard(original)

        # Find the closest palindrome
        min_diff = float('inf')
        result = None
        for candidate in candidates:
            diff = abs(candidate - original)
            if diff < min_diff or (diff == min_diff and candidate < result):
                min_diff = diff
                result = candidate

        return str(result)