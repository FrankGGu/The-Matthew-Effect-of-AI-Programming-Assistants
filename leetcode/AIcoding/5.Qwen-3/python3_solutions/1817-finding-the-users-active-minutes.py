from collections import defaultdict
from typing import List

class Solution:
    def findingUsersActiveMinutes(self, logs: List[List[str]], k: int) -> List[int]:
        user_time = defaultdict(set)
        for user, time in logs:
            user_time[user].add(time)

        result = [0] * k
        for user in user_time:
            count = len(user_time[user])
            if 0 < count <= k:
                result[count - 1] += 1

        return result