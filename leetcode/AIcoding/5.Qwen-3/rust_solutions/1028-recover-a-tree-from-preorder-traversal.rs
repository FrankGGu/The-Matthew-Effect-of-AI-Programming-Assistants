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

struct Solution;

impl Solution {
    pub fn recover_from_preorder(s: String) -> Option<Rc<RefCell<TreeNode>>> {
        let mut chars = s.chars().peekable();
        let root = Self::parse_node(&mut chars, 0);
        root
    }

    fn parse_node(chars: &mut std::iter::Peekable<std::str::Chars>, depth: usize) -> Option<Rc<RefCell<TreeNode>>> {
        let mut val = String::new();
        while chars.peek().map_or(false, |c| !c.is_ascii_digit()) {
            chars.next();
        }
        while let Some(c) = chars.next() {
            if c.is_ascii_digit() {
                val.push(c);
            } else {
                chars.put(c);
                break;
            }
        }
        if val.is_empty() {
            return None;
        }
        let node = Rc::new(RefCell::new(TreeNode::new(val.parse().unwrap())));
        let current_depth = depth;
        let mut next_depth = 0;
        while let Some(c) = chars.next() {
            if c == '-' {
                next_depth += 1;
            } else {
                chars.put(c);
                break;
            }
        }
        if next_depth > current_depth {
            node.borrow_mut().left = Self::parse_node(chars, next_depth);
        }
        if next_depth > current_depth {
            node.borrow_mut().right = Self::parse_node(chars, next_depth);
        }
        Some(node)
    }
}
}