impl Solution {

use std::collections::{HashSet, VecDeque};

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>,
}

pub fn is_disconnected(root: Option<Box<TreeNode>>) -> bool {
    fn dfs(node: &Option<Box<TreeNode>>, path: &mut Vec<i32>, paths: &mut HashSet<Vec<i32>>) {
        if let Some(n) = node {
            path.push(n.val);
            if n.left.is_none() && n.right.is_none() {
                paths.insert(path.clone());
            } else {
                dfs(&n.left, path, paths);
                dfs(&n.right, path, paths);
            }
            path.pop();
        }
    }

    let mut paths = HashSet::new();
    dfs(&root, &mut vec![], &mut paths);

    if paths.len() <= 1 {
        return false;
    }

    for path in paths.iter() {
        let mut temp = paths.clone();
        temp.remove(path);
        for other in temp.iter() {
            let mut flip_count = 0;
            for (a, b) in path.iter().zip(other.iter()) {
                if a != b {
                    flip_count += 1;
                    if flip_count > 1 {
                        break;
                    }
                }
            }
            if flip_count <= 1 {
                return true;
            }
        }
    }

    false
}
}