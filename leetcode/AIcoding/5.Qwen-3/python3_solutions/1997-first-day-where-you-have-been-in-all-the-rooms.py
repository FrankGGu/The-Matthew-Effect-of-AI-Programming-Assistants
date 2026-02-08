class Solution:
    def firstDayBeenInAllRooms(self, arr: List[int]) -> int:
        n = len(arr)
        visited = [False] * n
        current = 0
        day = 0
        while True:
            if visited[current]:
                return day
            visited[current] = True
            current = arr[current]
            day += 1