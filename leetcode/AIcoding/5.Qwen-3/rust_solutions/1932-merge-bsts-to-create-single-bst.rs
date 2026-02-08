impl Solution {

use std::cell::RefCell;
use std::cmp::Ordering;
use std::collections::VecDeque;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn merge_bsts(bsts: Vec<Option<Rc<RefCell<TreeNode>>>>) -> Option<Rc<RefCell<TreeNode>>> {
    if bsts.is_empty() {
        return None;
    }

    let mut nodes = vec![];
    for bst in &bsts {
        if let Some(root) = bst {
            let mut queue = VecDeque::new();
            queue.push_back(root.clone());
            while let Some(node) = queue.pop_front() {
                let node_ref = node.borrow();
                nodes.push(node_ref.val);
                if let Some(left) = &node_ref.left {
                    queue.push_back(left.clone());
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back(right.clone());
                }
            }
        }
    }

    if nodes.is_empty() {
        return None;
    }

    nodes.sort();

    let mut root = Rc::new(RefCell::new(TreeNode::new(nodes[0])));
    let mut queue = vec![root.clone()];
    let mut index = 1;

    while index < nodes.len() {
        let current = queue.remove(0);
        let current_val = current.borrow().val;

        if index < nodes.len() {
            let left = Rc::new(RefCell::new(TreeNode::new(nodes[index])));
            current.borrow_mut().left = Some(left.clone());
            queue.push(left);
            index += 1;
        }

        if index < nodes.len() {
            let right = Rc::new(RefCell::new(TreeNode::new(nodes[index])));
            current.borrow_mut().right = Some(right.clone());
            queue.push(right);
            index += 1;
        }
    }

    Some(root)
}
}