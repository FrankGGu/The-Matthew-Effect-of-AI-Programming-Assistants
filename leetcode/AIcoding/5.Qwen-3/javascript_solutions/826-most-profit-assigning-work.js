function maxProfitAssign(workers, difficulty, profit, worker) {
    const jobs = difficulty.map((d, i) => [d, profit[i]]);
    jobs.sort((a, b) => a[0] - b[0]);

    for (let i = 1; i < jobs.length; i++) {
        jobs[i][1] = Math.max(jobs[i][1], jobs[i - 1][1]);
    }

    let res = 0;
    let j = jobs.length - 1;

    for (let i = workers.length - 1; i >= 0; i--) {
        while (j >= 0 && workers[i] >= jobs[j][0]) {
            res = Math.max(res, jobs[j][1]);
            j--;
        }
    }

    return res;
}