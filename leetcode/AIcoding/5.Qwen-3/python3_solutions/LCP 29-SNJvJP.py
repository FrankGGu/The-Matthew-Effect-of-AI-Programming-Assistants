class Solution:
    def findValidMatrix(self, arr: List[int]) -> List[List[int]]:
        from collections import defaultdict

        count = defaultdict(int)
        for num in arr:
            count[num] += 1

        result = []
        while count:
            row = []
            to_remove = []
            for num in count:
                row.append(num)
                count[num] -= 1
                if count[num] == 0:
                    to_remove.append(num)
            for num in to_remove:
                del count[num]
            result.append(row)
        return result