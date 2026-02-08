class Solution:
    def minimumBoxes(self, apple: List[int], limit: int) -> int
        boxes = 0
        for a in apple:
            boxes += a // limit
            if a % limit != 0:
                boxes += 1
        return boxes