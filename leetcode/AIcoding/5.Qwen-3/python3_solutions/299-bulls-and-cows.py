class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        from collections import Counter

        bulls = 0
        cows = 0
        secret_count = Counter()
        guess_count = Counter()

        for s, g in zip(secret, guess):
            if s == g:
                bulls += 1
            else:
                secret_count[s] += 1
                guess_count[g] += 1

        for char in secret_count:
            cows += min(secret_count[char], guess_count.get(char, 0))

        return f"{bulls}A{cows}B"