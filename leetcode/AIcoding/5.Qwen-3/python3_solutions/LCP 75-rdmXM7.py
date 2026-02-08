class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: List[int], d: int) -> int:
        arr2.sort()
        distance = 0
        for num in arr1:
            left, right = 0, len(arr2) - 1
            while left <= right:
                mid = (left + right) // 2
                if abs(num - arr2[mid]) < d:
                    break
                elif num < arr2[mid]:
                    right = mid - 1
                else:
                    left = mid + 1
            else:
                distance += 1
        return distance