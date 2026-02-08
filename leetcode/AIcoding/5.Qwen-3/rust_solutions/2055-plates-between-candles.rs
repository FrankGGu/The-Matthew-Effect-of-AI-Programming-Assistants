impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn plates_between_candles(boxes: String, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = boxes.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];
        let mut prefix = vec![0; n];

        let mut prev = -1;
        for i in 0..n {
            if boxes.as_bytes()[i] == b'*' {
                prev = i as i32;
            }
            left[i] = prev;
        }

        prev = -1;
        for i in (0..n).rev() {
            if boxes.as_bytes()[i] == b'*' {
                prev = i as i32;
            }
            right[i] = prev;
        }

        let mut count = 0;
        for i in 0..n {
            if boxes.as_bytes()[i] == b'*' {
                count += 1;
            }
            prefix[i] = count;
        }

        let mut res = vec![];
        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let first = right[l];
            let last = left[r];
            if first == -1 || last == -1 || first >= last {
                res.push(0);
            } else {
                let total = prefix[last as usize] - prefix[first as usize];
                res.push(total);
            }
        }

        res
    }
}
}