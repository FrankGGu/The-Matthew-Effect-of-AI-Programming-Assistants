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

pub fn find_second_minimum_node(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, min_val: i32, second_min: &mut i32) {
        if let Some(n) = node {
            if n.val != min_val && n.val < *second_min {
                *second_min = n.val;
            }
            dfs(&n.left, min_val, second_min);
            dfs(&n.right, min_val, second_min);
        }
    }

    let mut second_min = i32::MAX;
    let min_val = root.as_ref().map(|n| n.val).unwrap_or(i32::MAX);
    dfs(&root, min_val, &mut second_min);
    if second_min == i32::MAX {
        -1
    } else {
        second_min
    }
}
}