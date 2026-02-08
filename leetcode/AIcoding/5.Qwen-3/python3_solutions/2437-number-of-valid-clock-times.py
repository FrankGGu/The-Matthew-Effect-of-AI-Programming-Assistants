class Solution:
    def countTime(self, time: str) -> int:
        hours, minutes = time.split(':')
        count = 0
        for h in range(24):
            for m in range(60):
                if (hours[0] == '?' or str(h)[0] == hours[0]) and (hours[1] == '?' or str(h)[1] == hours[1]) and (minutes[0] == '?' or str(m)[0] == minutes[0]) and (minutes[1] == '?' or str(m)[1] == minutes[1]):
                    count += 1
        return count