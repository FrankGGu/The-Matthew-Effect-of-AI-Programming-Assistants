class Solution:
    def booksArrange(self, books: List[int], k: int) -> int:
        from collections import deque

        q = deque()
        for book in books:
            while q and q[-1] < book:
                q.pop()
            q.append(book)

        return list(q)[:k]