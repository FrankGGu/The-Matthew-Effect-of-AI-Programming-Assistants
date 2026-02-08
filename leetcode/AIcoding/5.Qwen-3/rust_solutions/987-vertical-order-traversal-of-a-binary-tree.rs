impl Solution {

use std::collections::{HashMap, VecDeque};
use std::cell::RefCell;
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

pub fn vertical_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
    use std::cmp::Ordering;

    if root.is_none() {
        return vec![];
    }

    let mut column_map: HashMap<i32, Vec<i32>> = HashMap::new();
    let mut queue = VecDeque::new();
    queue.push_back((root.unwrap(), 0, 0));

    let mut min_col = 0;
    let mut max_col = 0;

    while let Some((node, row, col)) = queue.pop_front() {
        let node_ref = node.borrow();
        column_map.entry(col).or_insert_with(Vec::new).push(node_ref.val);

        if let Some(left) = &node_ref.left {
            queue.push_back((left.clone(), row + 1, col - 1));
            min_col = min_col.min(col - 1);
        }

        if let Some(right) = &node_ref.right {
            queue.push_back((right.clone(), row + 1, col + 1));
            max_col = max_col.max(col + 1);
        }
    }

    let mut result = Vec::with_capacity(max_col - min_col + 1);
    for col in min_col..=max_col {
        result.push(column_map.get(&col).unwrap().clone());
    }

    result
}
}