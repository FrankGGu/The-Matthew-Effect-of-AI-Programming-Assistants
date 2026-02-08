impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn balance_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    let mut nodes = Vec::new();
    in_order_traversal(root, &mut nodes);
    build_balanced_bst(&nodes, 0, nodes.len() - 1)
}

fn in_order_traversal(
    root: Option<Rc<RefCell<TreeNode>>>,
    nodes: &mut Vec<Rc<RefCell<TreeNode>>>,
) {
    if let Some(node) = root {
        in_order_traversal(node.borrow().left.clone(), nodes);
        nodes.push(node);
        in_order_traversal(node.borrow().right.clone(), nodes);
    }
}

fn build_balanced_bst(
    nodes: &[Rc<RefCell<TreeNode>>],
    left: usize,
    right: usize,
) -> Option<Rc<RefCell<TreeNode>>> {
    if left > right {
        return None;
    }
    let mid = left + (right - left) / 2;
    let node = nodes[mid].clone();
    let left_child = build_balanced_bst(nodes, left, mid - 1);
    let right_child = build_balanced_bst(nodes, mid + 1, right);
    node.borrow_mut().left = left_child;
    node.borrow_mut().right = right_child;
    Some(node)
}
}