function maxSumAfterRemovals(nums, remove) {
    const n = nums.length;
    const parent = new Array(n).fill(0).map((_, i) => i);
    const size = new Array(n).fill(1);

    function find(u) {
        while (parent[u] !== u) {
            parent[u] = parent[parent[u]];
            u = parent[u];
        }
        return u;
    }

    function union(u, v) {
        const rootU = find(u);
        const rootV = find(v);
        if (rootU === rootV) return;
        if (size[rootU] < size[rootV]) {
            [rootU, rootV] = [rootV, rootU];
        }
        parent[rootV] = rootU;
        size[rootU] += size[rootV];
    }

    const sumMap = new Map();
    for (let i = 0; i < n; i++) {
        sumMap.set(i, nums[i]);
    }

    for (let i = 0; i < n - 1; i++) {
        union(i, i + 1);
    }

    const rootSet = new Set();
    for (let i = 0; i < n; i++) {
        rootSet.add(find(i));
    }

    const rootSum = new Map();
    for (const root of rootSet) {
        let total = 0;
        for (let i = 0; i < n; i++) {
            if (find(i) === root) {
                total += nums[i];
            }
        }
        rootSum.set(root, total);
    }

    const removeSet = new Set(remove);
    const availableRoots = [];
    for (const root of rootSet) {
        let hasRemove = false;
        for (let i = 0; i < n; i++) {
            if (find(i) === root && removeSet.has(i)) {
                hasRemove = true;
                break;
            }
        }
        if (!hasRemove) {
            availableRoots.push(root);
        }
    }

    let maxSum = 0;
    for (const root of availableRoots) {
        maxSum = Math.max(maxSum, rootSum.get(root));
    }

    return maxSum;
}