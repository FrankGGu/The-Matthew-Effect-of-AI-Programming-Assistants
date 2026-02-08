var tree2str = function(t) {
    if (!t) return "";
    if (!t.left && !t.right) return t.val.toString();
    if (!t.right) return t.val + "(" + tree2str(t.left) + ")";
    return t.val + "(" + tree2str(t.left) + ")(" + tree2str(t.right) + ")";
};