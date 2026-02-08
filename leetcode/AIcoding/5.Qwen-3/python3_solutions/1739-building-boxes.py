class Solution:
    def minBoxes(self, n: int) -> int:
        from math import sqrt

        def get_total(k):
            return k * (k + 1) // 2

        def get_layer(k):
            return k * (k + 1) * (2 * k + 1) // 6

        total = 0
        layer = 0
        while True:
            layer += 1
            if get_total(layer) > n:
                break
            total += get_layer(layer)
            n -= get_total(layer)

        if n == 0:
            return total

        for i in range(1, layer + 1):
            if get_total(i) > n:
                return total + i - 1

        return total + layer