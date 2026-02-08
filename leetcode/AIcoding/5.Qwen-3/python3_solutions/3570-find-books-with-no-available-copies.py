class Solution:
    def findBooksWithNoAvailableCopies(self, books: List[Tuple[str, int, int]]) -> List[str]:
        result = []
        for book in books:
            if book[2] == 0:
                result.append(book[0])
        return result