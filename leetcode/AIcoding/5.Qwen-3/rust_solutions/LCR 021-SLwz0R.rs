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

pub fn remove_nth_from_end(head: Option<Box<ListNode>>, n: i32) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
    let mut slow = dummy.as_mut();
    let mut fast = dummy.as_ref();

    for _ in 0..n {
        fast = fast.as_ref().unwrap().next.as_ref();
    }

    while let Some(node) = fast {
        slow = slow.unwrap().next.as_mut();
        fast = node.next.as_ref();
    }

    let next = slow.unwrap().next.as_ref().unwrap().next.clone();
    slow.unwrap().next = next;

    dummy.unwrap().next
}
}