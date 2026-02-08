class Solution:
    def latestTimeCatchTheBus(self, busTimes: List[int], passengerTimes: List[int]) -> int:
        busTimes.sort()
        passengerTimes.sort()
        i = 0
        n = len(passengerTimes)
        for time in busTimes:
            j = i
            while j < n and passengerTimes[j] <= time:
                j += 1
            if j == n:
                return time
            if j == i:
                return time
            i = j
        return passengerTimes[-1]