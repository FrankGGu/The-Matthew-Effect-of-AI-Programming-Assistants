class TopVotedCandidates:

    def __init__(self, ballots: List[int], times: List[int]):
        from collections import defaultdict
        self.votes = defaultdict(int)
        self.leader = []
        self.times = times
        max_vote = 0
        current_leader = -1
        for i in range(len(ballots)):
            self.votes[ballots[i]] += 1
            if self.votes[ballots[i]] > max_vote:
                max_vote = self.votes[ballots[i]]
                current_leader = ballots[i]
            elif self.votes[ballots[i]] == max_vote:
                current_leader = min(current_leader, ballots[i])
            self.leader.append(current_leader)

    def q(self, t: int) -> int:
        left, right = 0, len(self.times) - 1
        while left < right:
            mid = (left + right + 1) // 2
            if self.times[mid] <= t:
                left = mid
            else:
                right = mid - 1
        return self.leader[left]