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

pub fn merge_two_lists(
    l1: Option<Box<ListNode>>,
    l2: Option<Box<ListNode>>,
) -> Option<Box<ListNode>> {
    let mut dummy = Box::new(ListNode::new(0));
    let mut current = &mut dummy;

    let mut l1 = l1;
    let mut l2 = l2;

    while l1.is_some() || l2.is_some() {
        if l1.is_none() {
            current.next = l2;
            break;
        } else if l2.is_none() {
            current.next = l1;
            break;
        } else {
            if l1.as_ref().unwrap().val <= l2.as_ref().unwrap().val {
                current.next = l1;
                l1 = current.next.as_mut().unwrap().next.take();
            } else {
                current.next = l2;
                l2 = current.next.as_mut().unwrap().next.take();
            }
        }

        current = current.next.as_mut().unwrap();
    }

    dummy.next
}
}