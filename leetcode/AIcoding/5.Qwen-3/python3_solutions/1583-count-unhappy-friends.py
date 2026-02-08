class Solution:
    def unhappyFriends(self, n: int, dislikes: List[List[int]], preferred: List[List[int]]) -> int:
        rank = [0] * n
        for i in range(n):
            for j in range(n):
                rank[preferred[i][j]] = j

        isUnhappy = [False] * n
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                if rank[i] < rank[j] and rank[i] < rank[dislikes[j][0]]:
                    isUnhappy[i] = True
                    break

        return sum(isUnhappy)