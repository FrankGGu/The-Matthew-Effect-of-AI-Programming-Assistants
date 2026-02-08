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

pub fn delete_duplicates(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    let mut dummy = Some(Box::new(ListNode { val: 0, next: head }));
    let mut current = dummy.as_mut();

    while let Some(node) = current {
        let val = node.val;
        let mut next = node.next.as_ref();

        while let Some(next_node) = next {
            if next_node.val == val {
                next = next_node.next.as_ref();
            } else {
                break;
            }
        }

        if node.next.as_ref() != next {
            node.next = next.cloned();
        } else {
            current = node.next.as_mut();
        }
    }

    dummy.unwrap().next
}
}