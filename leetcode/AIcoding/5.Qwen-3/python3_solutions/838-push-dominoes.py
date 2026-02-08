class Solution:
    def pushDominoes(self, dominoes: str) -> str:
        n = len(dominoes)
        force = [0] * n
        right = -1
        for i in range(n):
            if dominoes[i] == 'R':
                right = i
            elif dominoes[i] == 'L':
                right = -1
            if right != -1:
                force[right] += 1
                right += 1
        left = -1
        for i in range(n-1, -1, -1):
            if dominoes[i] == 'L':
                left = i
            elif dominoes[i] == 'R':
                left = -1
            if left != -1:
                force[left] -= 1
                left -= 1
        res = []
        for f in force:
            if f > 0:
                res.append('R')
            elif f < 0:
                res.append('L')
            else:
                res.append('.')
        return ''.join(res)