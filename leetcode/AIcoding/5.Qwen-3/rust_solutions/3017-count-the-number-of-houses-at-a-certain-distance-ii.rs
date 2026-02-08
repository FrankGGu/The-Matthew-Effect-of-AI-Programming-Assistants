impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn distance_k(root: Option<Rc<RefCell<TreeNode>>>, target: Option<Rc<RefCell<TreeNode>>>, k: i32) -> Vec<i32> {
        let mut graph = HashMap::new();
        Self::build_graph(&root, None, &mut graph);

        let mut queue = VecDeque::new();
        let target_node = target.as_ref().unwrap().clone();
        queue.push_back((target_node, 0));
        let mut visited = HashMap::new();
        visited.insert(target_node.borrow().val, true);

        let mut result = Vec::new();

        while let Some((node, dist)) = queue.pop_front() {
            if dist == k {
                result.push(node.borrow().val);
                continue;
            }

            for neighbor in graph.get(&node.borrow().val).unwrap_or(&vec![]) {
                if !visited.contains_key(&neighbor.borrow().val) {
                    visited.insert(neighbor.borrow().val, true);
                    queue.push_back((neighbor.clone(), dist + 1));
                }
            }
        }

        result
    }

    fn build_graph(node: &Option<Rc<RefCell<TreeNode>>>, parent: Option<Rc<RefCell<TreeNode>>>, graph: &mut HashMap<i32, Vec<Rc<RefCell<TreeNode>>>>) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if let Some(p) = parent {
                graph.entry(val).or_insert_with(Vec::new).push(p.clone());
                graph.entry(p.borrow().val).or_insert_with(Vec::new).push(n.clone());
            }

            Self::build_graph(&n.borrow().left, Some(n.clone()), graph);
            Self::build_graph(&n.borrow().right, Some(n.clone()), graph);
        }
    }
}

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct Solution {}
}