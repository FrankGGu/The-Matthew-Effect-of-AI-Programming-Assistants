class Solution:
    def hardestButton(self, releaseTimes, keysPressed):
        max_time = 0
        result = keysPressed[0]
        prev_time = 0
        for i in range(len(releaseTimes)):
            current_time = releaseTimes[i] - prev_time
            if current_time > max_time:
                max_time = current_time
                result = keysPressed[i]
            elif current_time == max_time:
                if keysPressed[i] < result:
                    result = keysPressed[i]
            prev_time = releaseTimes[i]
        return result