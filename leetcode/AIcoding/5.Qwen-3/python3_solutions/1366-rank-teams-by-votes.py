from collections import defaultdict

class Solution:
    def rankTeams(self, votes: List[str]) -> List[str]:
        if not votes:
            return []

        count = defaultdict(lambda: [0] * 26)
        for vote in votes:
            for i, ch in enumerate(vote):
                count[ch][i] += 1

        sorted_teams = sorted(count.keys(), key=lambda x: (-count[x][0], x))
        return sorted_teams