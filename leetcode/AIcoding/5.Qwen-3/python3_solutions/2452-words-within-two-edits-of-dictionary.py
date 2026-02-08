class Solution:
    def twoEditWords(self, queries: List[str], dictionary: List[str]) -> List[str]:
        result = []
        for q in queries:
            for d in dictionary:
                diff = 0
                for a, b in zip(q, d):
                    if a != b:
                        diff += 1
                        if diff > 2:
                            break
                if diff <= 2:
                    result.append(q)
                    break
        return result