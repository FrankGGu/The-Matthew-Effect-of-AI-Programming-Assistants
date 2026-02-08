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

pub fn count_pairs(root: Option<Box<TreeNode>>, distance: i32) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, distance: i32, result: &mut i32) -> Vec<i32> {
        if let Some(n) = node {
            if n.left.is_none() && n.right.is_none() {
                return vec![0];
            }

            let left = dfs(&n.left, distance, result);
            let right = dfs(&n.right, distance, result);

            let mut leaves = Vec::new();
            for d in left {
                if d + 1 < distance {
                    leaves.push(d + 1);
                }
            }
            for d in right {
                if d + 1 < distance {
                    leaves.push(d + 1);
                }
            }

            let mut count = HashMap::new();
            for d in left.iter() {
                *count.entry(d + 1).or_insert(0) += 1;
            }
            for d in right.iter() {
                *count.entry(d + 1).or_insert(0) += 1;
            }

            for (d, &c) in &count {
                if *d + 1 <= distance {
                    let other = count.get(&(distance - *d));
                    if let Some(&oc) = other {
                        *result += c * oc;
                    }
                }
            }

            leaves
        } else {
            vec![]
        }
    }

    let mut result = 0;
    dfs(&root, distance, &mut result);
    result
}
}