impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<ListNode>>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

struct Solution;

impl Solution {
    pub fn split_list_to_parts(
        head: Option<Rc<RefCell<ListNode>>>,
        k: i32,
    ) -> Vec<Option<Rc<RefCell<ListNode>>>> {
        let mut result = vec![None; k as usize];
        let mut current = head;
        let mut length = 0;

        // Calculate the length of the linked list
        let mut temp = current.clone();
        while let Some(node) = temp {
            length += 1;
            temp = node.borrow().next.clone();
        }

        let mut size = length / k;
        let mut remainder = length % k;

        let mut index = 0;
        while current.is_some() && index < k as usize {
            let mut new_head = current;
            let mut new_tail = new_head.clone();

            let mut count = 1;
            while count < size + (if remainder > 0 { 1 } else { 0 }) {
                if let Some(node) = new_tail {
                    new_tail = node.borrow().next.clone();
                    count += 1;
                }
            }

            if let Some(node) = new_tail {
                let next = node.borrow().next.clone();
                node.borrow_mut().next = None;
                current = next;
            } else {
                current = None;
            }

            result[index] = new_head;
            index += 1;

            if remainder > 0 {
                remainder -= 1;
            }
        }

        result
    }
}
}