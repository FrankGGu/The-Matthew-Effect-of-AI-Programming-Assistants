impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
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

use std::collections::VecDeque;

pub fn get_all_elements(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> Vec<i32> {
    fn traverse(root: Option<Box<TreeNode>>, queue: &mut VecDeque<i32>) {
        if let Some(node) = root {
            queue.push_back(node.val);
            traverse(node.left, queue);
            traverse(node.right, queue);
        }
    }

    let mut queue1 = VecDeque::new();
    let mut queue2 = VecDeque::new();

    traverse(root1, &mut queue1);
    traverse(root2, &mut queue2);

    let mut result = Vec::new();
    while !queue1.is_empty() && !queue2.is_empty() {
        if queue1[0] < queue2[0] {
            result.push(queue1.pop_front().unwrap());
        } else {
            result.push(queue2.pop_front().unwrap());
        }
    }

    while !queue1.is_empty() {
        result.push(queue1.pop_front().unwrap());
    }

    while !queue2.is_empty() {
        result.push(queue2.pop_front().unwrap());
    }

    result
}
}