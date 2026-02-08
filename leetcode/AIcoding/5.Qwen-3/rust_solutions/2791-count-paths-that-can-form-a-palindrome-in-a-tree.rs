impl Solution {

use std::collections::HashMap;

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

pub fn count_palindrome_paths(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, mask: i32, count: &mut HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let mut new_mask = mask ^ (1 << n.val);
            let mut res = 0;
            if let Some(&c) = count.get(&new_mask) {
                res += c;
            }
            if new_mask == 0 {
                res += 1;
            }

            *count.entry(new_mask).or_insert(0) += 1;

            res += dfs(&n.left, new_mask, count);
            res += dfs(&n.right, new_mask, count);

            *count.entry(new_mask).and_modify(|e| *e -= 1);

            res
        } else {
            0
        }
    }

    let mut count = HashMap::new();
    count.insert(0, 1);
    dfs(&root, 0, &mut count)
}
}