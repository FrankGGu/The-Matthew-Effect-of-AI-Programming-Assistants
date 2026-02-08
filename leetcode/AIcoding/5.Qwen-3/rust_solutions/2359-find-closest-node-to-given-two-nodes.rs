impl Solution {

use std::collections::{HashSet, VecDeque};

#[derive(Clone, Copy, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Box<Node>>,
    pub right: Option<Box<Node>>,
}

impl Node {
    pub fn new(val: i32) -> Self {
        Node {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn closest_node_to_given_two_nodes(root: Option<Box<Node>>, x: i32, y: i32) -> i32 {
    fn find_path(root: &Option<Box<Node>>, target: i32, path: &mut Vec<i32>) -> bool {
        if let Some(node) = root {
            path.push(node.val);
            if node.val == target {
                return true;
            }
            if find_path(&node.left, target, path) || find_path(&node.right, target, path) {
                return true;
            }
            path.pop();
        }
        false
    }

    fn get_lca(root: &Option<Box<Node>>, x: i32, y: i32) -> i32 {
        let mut path_x = vec![];
        let mut path_y = vec![];
        find_path(root, x, &mut path_x);
        find_path(root, y, &mut path_y);

        let mut i = 0;
        while i < path_x.len() && i < path_y.len() && path_x[i] == path_y[i] {
            i += 1;
        }

        path_x[i - 1]
    }

    fn get_closest_node(root: &Option<Box<Node>>, target: i32) -> i32 {
        let mut queue = VecDeque::new();
        let mut min_dist = i32::MAX;
        let mut result = -1;

        if let Some(node) = root {
            queue.push_back((node, 0));
        }

        while let Some((node, dist)) = queue.pop_front() {
            if dist < min_dist {
                min_dist = dist;
                result = node.val;
            }
            if let Some(left) = &node.left {
                queue.push_back((left.clone(), dist + 1));
            }
            if let Some(right) = &node.right {
                queue.push_back((right.clone(), dist + 1));
            }
        }

        result
    }

    let lca = get_lca(&root, x, y);
    let mut path = vec![];
    find_path(&root, lca, &mut path);
    let mut closest = lca;

    for &node_val in &path {
        let current = get_closest_node(&root, node_val);
        if current != -1 {
            closest = current;
        }
    }

    closest
}
}