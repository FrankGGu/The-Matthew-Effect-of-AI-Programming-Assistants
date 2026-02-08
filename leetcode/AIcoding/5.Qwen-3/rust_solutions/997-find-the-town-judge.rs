impl Solution {

use std::collections::HashMap;

fn main() {}

struct Solution {}

impl Solution {
    pub fn find_judge(n: i32, trust: Vec<Vec<i32>>) -> i32 {
        if n == 1 {
            return 1;
        }

        let mut count = vec![0; n as usize];

        for t in trust {
            count[t[0] as usize - 1] -= 1;
            count[t[1] as usize - 1] += 1;
        }

        for (i, &c) in count.iter().enumerate() {
            if c == n - 1 {
                return i as i32 + 1;
            }
        }

        -1
    }
}
}