class Solution:
    def findSolution(self, customfunction, z):
        result = []
        x = 1
        y = 1
        while True:
            val = customfunction.f(x, y)
            if val == z:
                result.append([x, y])
                x += 1
                y += 1
            elif val < z:
                x += 1
            else:
                y += 1
            if x > 100 or y > 100:
                break
        return result