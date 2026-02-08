impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn find_mode(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
    let mut freq_map = std::collections::HashMap::new();
    let mut max_freq = 0;

    fn traverse(node: &Option<Rc<RefCell<TreeNode>>>, freq_map: &mut std::collections::HashMap<i32, i32>, max_freq: &mut i32) {
        if let Some(n) = node {
            let node = n.borrow();
            *freq_map.entry(node.val).or_insert(0) += 1;
            *max_freq = std::cmp::max(*max_freq, *freq_map.get(&node.val).unwrap());

            traverse(&node.left, freq_map, max_freq);
            traverse(&node.right, freq_map, max_freq);
        }
    }

    traverse(&root, &mut freq_map, &mut max_freq);

    freq_map
        .into_iter()
        .filter(|&(_, v)| v == max_freq)
        .map(|(k, _)| k)
        .collect()
}
}