impl Solution {

use std::collections::{HashSet, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn collect_coins(root: Option<Box<TreeNode>>) -> i32 {
    fn dfs(node: &Option<Box<TreeNode>>, depth: i32, result: &mut Vec<i32>) {
        if let Some(n) = node {
            result.push(depth);
            dfs(&n.left, depth + 1, result);
            dfs(&n.right, depth + 1, result);
        }
    }

    let mut depths = Vec::new();
    dfs(&root, 0, &mut depths);

    if depths.is_empty() {
        return 0;
    }

    let mut leaves = depths.clone();
    let mut degree = HashSet::new();

    for &d in &depths {
        degree.insert(d);
    }

    let mut queue = VecDeque::new();
    for &d in &depths {
        queue.push_back(d);
    }

    while !queue.is_empty() {
        let size = queue.len();
        for _ in 0..size {
            let d = queue.pop_front().unwrap();
            if degree.contains(&d) {
                degree.remove(&d);
                if let Some(prev) = d.checked_sub(1) {
                    if degree.contains(&prev) {
                        queue.push_back(prev);
                    }
                }
            }
        }
    }

    let mut max_depth = 0;
    for &d in &depths {
        if d > max_depth {
            max_depth = d;
        }
    }

    let mut res = 0;
    for &d in &depths {
        if d < max_depth {
            res += (max_depth - d) * 2;
        }
    }

    res
}
}