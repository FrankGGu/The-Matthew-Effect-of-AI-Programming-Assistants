function equationsPossible(nums) {
    const parent = {};

    function find(x) {
        if (!parent[x]) parent[x] = x;
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        parent[find(x)] = find(y);
    }

    for (const num of nums) {
        if (num[1] === '=') {
            union(num[0], num[3]);
        }
    }

    for (const num of nums) {
        if (num[1] === '!' && find(num[0]) === find(num[3])) {
            return false;
        }
    }

    return true;
}