class Solution:
    def splitEvenNumber(self, num: int) -> List[int]:
        result = []
        while num > 0:
            if num >= 2:
                result.append(2)
                num -= 2
            else:
                break
        return result