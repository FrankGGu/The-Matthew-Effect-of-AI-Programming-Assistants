class Solution:
    def superWashingMachines(self, machines: list[int]) -> int:
        total = sum(machines)
        n = len(machines)
        if total % n != 0:
            return -1
        avg = total // n
        res = 0
        for i in range(n):
            machines[i] -= avg
        for i in range(n):
            if i > 0:
                machines[i] += machines[i - 1]
            res = max(res, abs(machines[i]))
        return res