impl Solution {

use std::collections::{HashMap, HashSet};

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

pub fn smallest_missing_genetic_value(mut root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut res = vec![1; 100_001];
    let mut seen = HashSet::new();
    let mut parent = HashMap::new();

    // First pass: find the node with value 1 and build parent map
    fn dfs(node: &Option<Box<TreeNode>>, parent: &mut HashMap<i32, i32>, seen: &mut HashSet<i32>) {
        if let Some(n) = node {
            seen.insert(n.val);
            if let Some(left) = &n.left {
                parent.insert(left.val, n.val);
                dfs(&Some(left.clone()), parent, seen);
            }
            if let Some(right) = &n.right {
                parent.insert(right.val, n.val);
                dfs(&Some(right.clone()), parent, seen);
            }
        }
    }

    dfs(&root, &mut parent, &mut seen);

    // If 1 is not present, return all 1s
    if !seen.contains(&1) {
        return res;
    }

    // Second pass: collect all values in the subtree of 1
    let mut sub_seen = HashSet::new();
    let mut stack = vec![root.unwrap()];
    while let Some(node) = stack.pop() {
        sub_seen.insert(node.val);
        if let Some(left) = node.left {
            stack.push(left);
        }
        if let Some(right) = node.right {
            stack.push(right);
        }
    }

    // Third pass: mark all seen values in res
    for &v in &sub_seen {
        if v <= 100_000 {
            res[v as usize] = 0;
        }
    }

    // Find the smallest missing value
    let mut min_missing = 1;
    while min_missing <= 100_000 && res[min_missing as usize] == 0 {
        min_missing += 1;
    }

    // Update all nodes in the path from 1 to root
    let mut current = 1;
    while let Some(p) = parent.get(&current) {
        current = *p;
        if current <= 100_000 {
            res[current as usize] = min_missing;
        }
    }

    res
}
}