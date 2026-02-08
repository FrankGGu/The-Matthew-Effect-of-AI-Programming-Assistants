class Solution:
    def findNumOfValidWords(self, words: List[str], puzzles: List[str]) -> List[int]:
        from collections import defaultdict

        count = defaultdict(int)
        for word in words:
            mask = 0
            for c in word:
                mask |= 1 << (ord(c) - ord('a'))
            count[mask] += 1

        result = []
        for puzzle in puzzles:
            total = 0
            for i in range(26):
                if (1 << i) & (1 << (ord(puzzle[0]) - ord('a'))):
                    continue
                if (1 << i) & (1 << (ord(puzzle[0]) - ord('a'))) == 0:
                    temp_mask = 0
                    for c in puzzle:
                        temp_mask |= 1 << (ord(c) - ord('a'))
                    temp_mask ^= (1 << i)
                    total += count.get(temp_mask, 0)
            result.append(total)
        return result