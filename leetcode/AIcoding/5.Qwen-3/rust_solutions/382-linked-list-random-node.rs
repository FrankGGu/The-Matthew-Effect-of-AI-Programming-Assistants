impl Solution {

use rand::seq::SliceRandom;
use rand::Rng;

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

pub struct Solution {
    head: Option<Box<ListNode>>,
}

impl Solution {
    pub fn new(head: Option<Box<ListNode>>) -> Self {
        Solution { head }
    }

    pub fn get_random(&self) -> i32 {
        let mut rng = rand::thread_rng();
        let mut node = self.head.as_ref();
        let mut result = 0;
        let mut count = 0;

        while let Some(n) = node {
            count += 1;
            if rng.gen_range(0..count) == 0 {
                result = n.val;
            }
            node = n.next.as_ref();
        }

        result
    }
}
}