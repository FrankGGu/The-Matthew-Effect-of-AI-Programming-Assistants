impl Solution {

use std::collections::HashMap;
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

pub fn remove_zero_sum_subarrays(head: Option<Rc<RefCell<ListNode>>>) -> Option<Rc<RefCell<ListNode>>> {
    let dummy = Rc::new(RefCell::new(ListNode { val: 0, next: head }));
    let mut map = HashMap::new();
    map.insert(0, dummy.clone());
    let mut curr = dummy.clone();
    let mut prefix_sum = 0;

    while let Some(node) = curr.borrow().next.clone() {
        prefix_sum += node.borrow().val;
        if let Some(&prev) = map.get(&prefix_sum) {
            let mut prev_node = prev.clone();
            let mut temp = prev_node.borrow_mut();
            let mut next_node = temp.next.clone();
            while next_node.is_some() && next_node.as_ref().unwrap().borrow().val != node.borrow().val {
                let next_next = next_node.as_ref().unwrap().borrow().next.clone();
                temp.next = next_next;
                next_node = temp.next.clone();
            }
            temp.next = node.borrow().next.clone();
        } else {
            map.insert(prefix_sum, curr.clone());
        }
        curr = node;
    }

    dummy.borrow().next.clone()
}
}