function findShortestSuperstring(nums) {
    const n = nums.length;
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));
    const prev = Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                dp[i][j] = nums[i].length + nums[j].length - overlap(nums[i], nums[j]);
            }
        }
    }

    let minLen = Infinity;
    let last = -1;

    for (let i = 0; i < n; i++) {
        let curr = 0;
        let used = Array(n).fill(false);
        used[i] = true;
        let len = nums[i].length;

        for (let j = 0; j < n - 1; j++) {
            let max = -1;
            let next = -1;
            for (let k = 0; k < n; k++) {
                if (!used[k]) {
                    const val = dp[i][k];
                    if (val > max) {
                        max = val;
                        next = k;
                    }
                }
            }
            if (next === -1) break;
            used[next] = true;
            len += max - nums[i].length;
            i = next;
        }

        if (len < minLen) {
            minLen = len;
            last = i;
        }
    }

    const result = [];
    let used = Array(n).fill(false);
    let i = last;
    used[i] = true;

    while (true) {
        result.push(nums[i]);
        let next = -1;
        for (let j = 0; j < n; j++) {
            if (!used[j] && dp[i][j] === nums[i].length + nums[j].length - overlap(nums[i], nums[j])) {
                next = j;
                break;
            }
        }
        if (next === -1) break;
        used[next] = true;
        i = next;
    }

    return result.join('');
}

function overlap(a, b) {
    const minLen = Math.min(a.length, b.length);
    for (let i = minLen; i > 0; i--) {
        if (a.endsWith(b.substring(0, i))) {
            return i;
        }
    }
    return 0;
}