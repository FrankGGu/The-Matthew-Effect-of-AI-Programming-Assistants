impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_total_reward(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: &Option<Box<TreeNode>>, map: &mut HashMap<i32, i32>) -> i32 {
            if let Some(n) = node {
                let left = dfs(&n.left, map);
                let right = dfs(&n.right, map);
                let val = n.val;
                let mut max_val = 0;
                for (k, v) in map {
                    if *k < val {
                        max_val = max_val.max(*v);
                    }
                }
                let current = max_val + val;
                map.insert(val, current);
                return current.max(left).max(right);
            }
            0
        }

        let mut map = HashMap::new();
        dfs(&root, &mut map)
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Solution;
}