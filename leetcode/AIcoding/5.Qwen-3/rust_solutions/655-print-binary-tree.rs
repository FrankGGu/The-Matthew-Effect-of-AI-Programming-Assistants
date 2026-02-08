impl Solution {

use std::rc::Rc;
use std::cell::RefCell;
use std::vec::Vec;

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

pub fn print_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<String>> {
    fn get_height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            1 + std::cmp::max(get_height(&n.left), get_height(&n.right))
        } else {
            0
        }
    }

    fn fill_tree(
        node: &Option<Rc<RefCell<TreeNode>>>,
        row: i32,
        col: i32,
        res: &mut Vec<Vec<String>>,
    ) {
        if let Some(n) = node {
            let n = n.borrow();
            res[row as usize][col as usize] = n.val.to_string();
            fill_tree(&n.left, row + 1, col - 1, res);
            fill_tree(&n.right, row + 1, col + 1, res);
        }
    }

    if root.is_none() {
        return vec![];
    }

    let height = get_height(&root);
    let width = (1 << height) - 1;
    let mut res = vec![vec!["".to_string(); width as usize]; height as usize];

    fill_tree(&root, 0, (width - 1) / 2, &mut res);

    res
}
}