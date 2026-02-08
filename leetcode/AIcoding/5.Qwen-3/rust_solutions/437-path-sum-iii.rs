impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, target: i32, prefix_sum: i32, map: &mut std::collections::HashMap<i32, i32>) -> i32 {
        if let Some(n) = node {
            let node = n.borrow();
            let current_sum = prefix_sum + node.val;
            let mut count = 0;

            if let Some(&v) = map.get(&(current_sum - target)) {
                count += v;
            }

            *map.entry(current_sum).or_insert(0) += 1;

            count += dfs(&node.left, target, current_sum, map);
            count += dfs(&node.right, target, current_sum, map);

            *map.entry(current_sum).or_insert(0) -= 1;

            count
        } else {
            0
        }
    }

    let mut map = std::collections::HashMap::new();
    map.insert(0, 1);
    dfs(&root, target_sum, 0, &mut map)
}
}