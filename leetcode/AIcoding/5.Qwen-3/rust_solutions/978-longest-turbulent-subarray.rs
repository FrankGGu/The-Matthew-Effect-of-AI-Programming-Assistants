impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_turbulence_size(mut arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return n as i32;
        }

        let mut max_len = 1;
        let mut curr_len = 1;

        for i in 1..n {
            match arr[i].cmp(&arr[i - 1]) {
                Ordering::Equal => {
                    curr_len = 1;
                }
                Ordering::Less => {
                    if i > 1 && arr[i - 1] > arr[i - 2] {
                        curr_len += 1;
                    } else {
                        curr_len = 2;
                    }
                }
                Ordering::Greater => {
                    if i > 1 && arr[i - 1] < arr[i - 2] {
                        curr_len += 1;
                    } else {
                        curr_len = 2;
                    }
                }
            }
            max_len = max_len.max(curr_len);
        }

        max_len
    }
}
}