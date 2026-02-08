var findFrequentTreeSum = function(root) {
    var map = {};
    var maxCount = 0;

    function dfs(node) {
        if (!node) return 0;
        var sum = node.val + dfs(node.left) + dfs(node.right);
        map[sum] = (map[sum] || 0) + 1;
        maxCount = Math.max(maxCount, map[sum]);
        return sum;
    }

    dfs(root);

    var result = [];
    for (var key in map) {
        if (map[key] === maxCount) {
            result.push(parseInt(key));
        }
    }

    return result;
};