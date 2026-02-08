impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq)]
struct HeapNode<'a> {
    val: i32,
    list: &'a mut ListNode,
}

impl<'a> Ord for HeapNode<'a> {
    fn cmp(&self, other: &Self) -> Ordering {
        self.val.cmp(&other.val)
    }
}

impl<'a> PartialOrd for HeapNode<'a> {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

#[derive(PartialEq, Eq)]
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

pub struct Solution;

impl Solution {
    pub fn merge_k_lists(lists: Vec<Option<Box<ListNode>>>) -> Option<Box<ListNode>> {
        let mut heap = BinaryHeap::new();
        for list in lists {
            if let Some(mut node) = list {
                heap.push(HeapNode {
                    val: node.val,
                    list: &mut node,
                });
            }
        }

        let mut dummy = Box::new(ListNode::new(0));
        let mut current = &mut dummy;

        while let Some(mut node) = heap.pop() {
            current.next = Some(Box::new(ListNode::new(node.val)));
            current = current.next.as_mut().unwrap();

            if let Some(next) = node.list.next.take() {
                node.list = &mut *next;
                heap.push(node);
            }
        }

        dummy.next
    }
}
}