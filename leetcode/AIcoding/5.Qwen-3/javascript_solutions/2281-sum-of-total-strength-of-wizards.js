function totalStrength(strength) {
    const MOD = 10 ** 9 + 7;
    const n = strength.length;

    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] >= strength[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && strength[stack[stack.length - 1]] > strength[i]) {
            stack.pop();
        }
        if (stack.length > 0) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    const prefix = new Array(n + 1).fill(0);
    const prefix2 = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        prefix2[i + 1] = (prefix2[i] + prefix[i + 1]) % MOD;
    }

    let result = 0;

    for (let i = 0; i < n; i++) {
        const l = left[i];
        const r = right[i];
        const leftCount = i - l;
        const rightCount = r - i;

        const sumLeft = (prefix[i + 1] - prefix[l + 1]) % MOD;
        const sumRight = (prefix[r] - prefix[i]) % MOD;

        const totalSum = (sumLeft * rightCount + sumRight * leftCount) % MOD;
        const totalContribution = (strength[i] * totalSum) % MOD;

        result = (result + totalContribution) % MOD;
    }

    return result;
}