function getDirections(root, startValue, destValue) {
    const pathToStart = [];
    const pathToDest = [];

    function findPath(node, target, path) {
        if (!node) return false;
        if (node.val === target) {
            return true;
        }
        if (findPath(node.left, target, path)) {
            path.push('L');
            return true;
        }
        if (findPath(node.right, target, path)) {
            path.push('R');
            return true;
        }
        return false;
    }

    findPath(root, startValue, pathToStart);
    findPath(root, destValue, pathToDest);

    let i = 0;
    while (i < pathToStart.length && i < pathToDest.length && pathToStart[i] === pathToDest[i]) {
        i++;
    }

    const upSteps = pathToStart.slice(i).map(() => 'U').join('');
    const downSteps = pathToDest.slice(i).join('');

    return upSteps + downSteps;
}