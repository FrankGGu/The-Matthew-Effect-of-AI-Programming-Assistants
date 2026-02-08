impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

use std::rc::Rc;
use std::cell::RefCell;

pub fn add_one_row(
    root: Option<Rc<RefCell<TreeNode>>>,
    val: i32,
    depth: i32,
) -> Option<Rc<RefCell<TreeNode>>> {
    if depth == 1 {
        return Some(Rc::new(RefCell::new(TreeNode {
            val,
            left: root,
            right: None,
        })));
    }

    let mut queue = std::collections::VecDeque::new();
    if let Some(node) = &root {
        queue.push_back(node.clone());
    }

    let mut current_depth = 1;

    while !queue.is_empty() && current_depth < depth - 1 {
        let level_size = queue.len();
        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                if let Some(left) = &node.borrow().left {
                    queue.push_back(left.clone());
                }
                if let Some(right) = &node.borrow().right {
                    queue.push_back(right.clone());
                }
            }
        }
        current_depth += 1;
    }

    while let Some(node) = queue.pop_front() {
        let mut node_borrow = node.borrow_mut();
        let left = node_borrow.left.take();
        let right = node_borrow.right.take();

        let new_left = Rc::new(RefCell::new(TreeNode {
            val,
            left: left,
            right: None,
        }));
        let new_right = Rc::new(RefCell::new(TreeNode {
            val,
            left: None,
            right: right,
        }));

        node_borrow.left = Some(new_left);
        node_borrow.right = Some(new_right);
    }

    root
}
}