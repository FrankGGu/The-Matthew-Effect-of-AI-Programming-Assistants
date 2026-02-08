from collections import deque

class Solution:
    def minMutation(self, startGene: str, endGene: str, bank: List[str], bankSet: set = None) -> int:
        if bankSet is None:
            bankSet = set(bank)
        queue = deque([(startGene, 0)])
        visited = set([startGene])
        chars = ['A', 'C', 'G', 'T']

        while queue:
            current, steps = queue.popleft()
            if current == endGene:
                return steps
            for char in chars:
                for i in range(8):
                    nextGene = current[:i] + char + current[i+1:]
                    if nextGene in bankSet and nextGene not in visited:
                        visited.add(nextGene)
                        queue.append((nextGene, steps + 1))
        return -1