function largestComponentSize(nums) {
    const maxNum = Math.max(...nums);
    const parent = Array(maxNum + 1).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
        }
    }

    for (let i = 2; i <= maxNum; i++) {
        for (let j = i * 2; j <= maxNum; j += i) {
            union(i, j);
        }
    }

    const map = new Map();
    let max = 0;

    for (const num of nums) {
        const root = find(num);
        map.set(root, (map.get(root) || 0) + 1);
        max = Math.max(max, map.get(root));
    }

    return max;
}