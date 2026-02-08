impl Solution {

use std::collections::{HashSet, VecDeque};

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

pub fn possible_root_nodes(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, visited: &mut HashSet<i32>, result: &mut HashSet<i32>) {
        if let Some(n) = node {
            let val = n.val;
            if !visited.contains(&val) {
                visited.insert(val);
                result.insert(val);
                dfs(&n.left, visited, result);
                dfs(&n.right, visited, result);
                visited.remove(&val);
            }
        }
    }

    let mut result = HashSet::new();
    let mut visited = HashSet::new();

    fn traverse(node: &Option<Box<TreeNode>>, visited: &mut HashSet<i32>, result: &mut HashSet<i32>) {
        if let Some(n) = node {
            let val = n.val;
            if !visited.contains(&val) {
                visited.insert(val);
                dfs(&n.left, visited, result);
                dfs(&n.right, visited, result);
                visited.remove(&val);
            }
        }
    }

    traverse(&root, &mut visited, &mut result);
    result.len() as i32
}
}