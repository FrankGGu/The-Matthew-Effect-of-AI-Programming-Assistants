impl Solution {

use std::collections::LinkedList;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn add_two_numbers(
    l1: Option<Box<ListNode>>,
    l2: Option<Box<ListNode>>,
) -> Option<Box<ListNode>> {
    let mut stack1 = LinkedList::new();
    let mut stack2 = LinkedList::new();

    let mut p = l1;
    while let Some(node) = p {
        stack1.push_back(node.val);
        p = node.next;
    }

    let mut p = l2;
    while let Some(node) = p {
        stack2.push_back(node.val);
        p = node.next;
    }

    let mut carry = 0;
    let mut result = None;

    while !stack1.is_empty() || !stack2.is_empty() || carry > 0 {
        let mut sum = carry;

        if let Some(val) = stack1.pop_back() {
            sum += val;
        }

        if let Some(val) = stack2.pop_back() {
            sum += val;
        }

        carry = sum / 10;
        let node = Box::new(ListNode {
            val: sum % 10,
            next: result,
        });
        result = Some(node);
    }

    result
}
}