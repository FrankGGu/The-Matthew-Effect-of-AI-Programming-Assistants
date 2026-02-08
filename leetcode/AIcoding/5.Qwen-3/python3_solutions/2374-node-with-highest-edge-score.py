class Solution:
    def mostConnected(self, nodes: List[List[int]]) -> int:
        score = [0] * len(nodes)
        for i in range(len(nodes)):
            for neighbor in nodes[i]:
                score[neighbor] += 1
        max_score = max(score)
        for i in range(len(score)):
            if score[i] == max_score:
                return i