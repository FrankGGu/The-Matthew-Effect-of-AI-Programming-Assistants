class Solution:
    def minimumTime(self, jobs: List[int], workers: List[int]) -> int:
        jobs.sort(reverse=True)
        workers.sort(reverse=True)
        res = 0
        for j, w in zip(jobs, workers):
            res = max(res, (j + w - 1) // w)
        return res