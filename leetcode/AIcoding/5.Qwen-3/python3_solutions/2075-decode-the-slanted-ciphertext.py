class Solution:
    def decodeCiphertext(self, s: str, rows: int) -> str:
        n = len(s)
        cols = (n + rows - 1) // rows
        result = []
        for r in range(rows):
            for c in range(cols):
                index = r + c * rows
                if index < n:
                    result.append(s[index])
        return ''.join(result)