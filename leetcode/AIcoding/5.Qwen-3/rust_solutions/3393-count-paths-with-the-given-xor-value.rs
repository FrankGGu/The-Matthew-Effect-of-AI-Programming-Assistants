impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_paths(root: Option<Box<TreeNode>>, target_xor: i32) -> i32 {
        let mut prefix_xor = HashMap::new();
        prefix_xor.insert(0, 1);
        Self::dfs(root.as_ref(), &mut prefix_xor, 0, target_xor)
    }

    fn dfs(node: Option<&Box<TreeNode>>, prefix_xor: &mut HashMap<i32, i32>, current_xor: i32, target: i32) -> i32 {
        if let Some(n) = node {
            let new_xor = current_xor ^ n.val;
            let count = *prefix_xor.get(&(new_xor ^ target)).unwrap_or(&0);
            *prefix_xor.entry(new_xor).or_insert(0) += 1;
            let left = Self::dfs(n.left.as_ref(), prefix_xor, new_xor, target);
            let right = Self::dfs(n.right.as_ref(), prefix_xor, new_xor, target);
            *prefix_xor.entry(new_xor).or_insert(0) -= 1;
            count + left + right
        } else {
            0
        }
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