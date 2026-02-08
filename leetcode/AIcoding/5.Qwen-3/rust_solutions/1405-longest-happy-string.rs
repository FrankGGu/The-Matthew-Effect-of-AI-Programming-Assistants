impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn longest_happy_string(a: i32, b: i32, c: i32) -> String {
        let mut max_heap = BinaryHeap::new();
        if a > 0 {
            max_heap.push((a, 'a'));
        }
        if b > 0 {
            max_heap.push((b, 'b'));
        }
        if c > 0 {
            max_heap.push((c, 'c'));
        }

        let mut result = Vec::with_capacity(a as usize + b as usize + c as usize);
        let mut prev_char = '\0';
        let mut prev_count = 0;

        while let Some((count, ch)) = max_heap.pop() {
            if ch == prev_char {
                if prev_count > 0 {
                    let mut new_count = count - 1;
                    if new_count > 0 {
                        max_heap.push((new_count, ch));
                    }
                    result.push(ch);
                    prev_count -= 1;
                } else {
                    result.push(ch);
                    prev_char = ch;
                    prev_count = count - 1;
                }
            } else {
                result.push(ch);
                prev_char = ch;
                prev_count = count - 1;
            }

            if !max_heap.is_empty() {
                let (next_count, next_ch) = max_heap.pop().unwrap();
                if next_count > 0 {
                    max_heap.push((next_count, next_ch));
                }
            }
        }

        result.into_iter().collect()
    }
}
}