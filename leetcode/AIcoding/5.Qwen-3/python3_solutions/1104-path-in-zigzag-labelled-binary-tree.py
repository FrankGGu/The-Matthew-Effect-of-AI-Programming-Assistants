class Solution:
    def pathInZigzagForm(self, label: int) -> List[int]:
        path = []
        while label > 0:
            path.append(label)
            label //= 2
        path.reverse()
        for i in range(1, len(path), 2):
            path[i] = (1 << (i + 1)) - 1 - path[i] + (1 << i)
        return path