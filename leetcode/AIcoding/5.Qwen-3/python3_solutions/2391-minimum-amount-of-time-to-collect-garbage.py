class Solution:
    def garbageCollection(self, garbage: List[str], travel: List[int]) -> int:
        time = 0
        for i in range(len(garbage)):
            time += len(garbage[i])
        for i in range(1, len(travel)):
            travel[i] += travel[i - 1]
        paper = 0
        glass = 0
        metal = 0
        for i in range(len(garbage)):
            if 'P' in garbage[i]:
                paper = i
            if 'G' in garbage[i]:
                glass = i
            if 'M' in garbage[i]:
                metal = i
        time += travel[paper] + travel[glass] + travel[metal]
        return time