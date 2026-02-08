impl Solution {

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

pub fn tree_height_after_queries(root: Option<Rc<RefCell<TreeNode>>>, queries: Vec<i32>) -> Vec<i32> {
    fn get_height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            1 + std::cmp::max(get_height(&n.left), get_height(&n.right))
        } else {
            0
        }
    }

    fn dfs(
        node: &Option<Rc<RefCell<TreeNode>>>,
        depth: i32,
        parent: &Option<Rc<RefCell<TreeNode>>>,
        height_map: &mut std::collections::HashMap<i32, i32>,
    ) {
        if let Some(n) = node {
            let n = n.borrow();
            let current_val = n.val;
            let left_height = get_height(&n.left);
            let right_height = get_height(&n.right);
            height_map.insert(current_val, 1 + std::cmp::max(left_height, right_height));

            dfs(&n.left, depth + 1, node, height_map);
            dfs(&n.right, depth + 1, node, height_map);
        }
    }

    let mut height_map = std::collections::HashMap::new();
    dfs(&root, 0, &None, &mut height_map);

    let mut result = Vec::new();
    for q in queries {
        result.push(height_map.get(&q).copied().unwrap_or(0));
    }

    result
}
}