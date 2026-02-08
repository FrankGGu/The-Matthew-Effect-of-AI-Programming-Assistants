function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) return false;
        left++;
        right--;
    }
    return true;
}

function dfs(node, path, result) {
    if (!node) return;
    path += node.val;
    if (!node.left && !node.right) {
        result.push(path);
    } else {
        dfs(node.left, path, result);
        dfs(node.right, path, result);
    }
}

function isPalindromePaths(root) {
    const result = [];
    dfs(root, "", result);
    for (const s of result) {
        if (!isPalindrome(s)) return false;
    }
    return true;
}