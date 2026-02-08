impl Solution {

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

pub fn merge_in_between(
    list1: Option<Box<ListNode>>,
    a: i32,
    list2: Option<Box<ListNode>>,
    b: i32,
) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = dummy.as_mut();
    let mut list1_current = list1;
    let mut a_count = 0;
    let mut b_count = 0;

    // Traverse to the node before the a-th node in list1
    while a_count < a - 1 {
        current.next = list1_current;
        current = current.next.as_mut().unwrap();
        list1_current = current.next.take();
        a_count += 1;
    }

    // Attach list2
    current.next = list2;
    while current.next.is_some() {
        current = current.next.as_mut().unwrap();
    }

    // Continue from the node after the b-th node in list1
    while b_count < b {
        list1_current = list1_current.and_then(|node| node.next);
        b_count += 1;
    }

    current.next = list1_current;

    dummy.next
}
}