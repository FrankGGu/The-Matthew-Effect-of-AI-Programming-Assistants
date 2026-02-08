impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn path_sum(root: Option<Box<TreeNode>>, target_sum: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut path = Vec::new();
    dfs(root, target_sum, &mut result, &mut path);
    result
}

fn dfs(node: Option<Box<TreeNode>>, target: i32, result: &mut Vec<Vec<i32>>, path: &mut Vec<i32>) {
    if let Some(n) = node {
        path.push(n.val);
        if n.left.is_none() && n.right.is_none() && target == n.val {
            result.push(path.clone());
        } else {
            dfs(n.left, target - n.val, result, path);
            dfs(n.right, target - n.val, result, path);
        }
        path.pop();
    }
}
}