class Solution:
    def booksArrange(self, books: list[int]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        for book in books:
            count[book] += 1
        res = 0
        for v in count.values():
            res += v // 2
        return res