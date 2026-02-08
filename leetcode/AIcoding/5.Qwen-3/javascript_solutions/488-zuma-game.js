function findMinSteps(board, hand) {
    const map = {};
    for (let c of hand) {
        map[c] = (map[c] || 0) + 1;
    }

    const memo = {};

    function dfs(s, handMap) {
        const key = s + JSON.stringify(handMap);
        if (memo[key] !== undefined) return memo[key];

        if (s.length === 0) return 0;

        let minSteps = Infinity;

        for (let i = 0; i < s.length; i++) {
            for (let c in handMap) {
                if (handMap[c] === 0) continue;

                if (i > 0 && s[i - 1] === c) continue;

                const newHand = { ...handMap };
                newHand[c]--;
                if (newHand[c] === 0) delete newHand[c];

                const newS = s.slice(0, i) + c + s.slice(i);
                const nextS = removeConsecutive(newS);

                const steps = dfs(nextS, newHand);
                if (steps !== Infinity) {
                    minSteps = Math.min(minSteps, 1 + steps);
                }
            }
        }

        memo[key] = minSteps;
        return minSteps;
    }

    function removeConsecutive(s) {
        let changed;
        do {
            changed = false;
            let i = 0;
            let res = [];
            while (i < s.length) {
                let j = i;
                while (j < s.length && s[j] === s[i]) j++;
                if (j - i >= 3) {
                    changed = true;
                } else {
                    res.push(s.substring(i, j));
                }
                i = j;
            }
            s = res.join('');
        } while (changed);
        return s;
    }

    const result = dfs(board, map);
    return result === Infinity ? -1 : result;
}