class Solution:
    def canThreePartsInternet(self, arr: List[int]) -> bool:
        total = sum(arr)
        if total % 3 != 0:
            return False
        target = total // 3
        count = 0
        current = 0
        for num in arr:
            current += num
            if current == target:
                count += 1
                current = 0
                if count == 2:
                    return True
        return False