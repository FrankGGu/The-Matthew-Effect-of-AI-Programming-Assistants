impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn magical_string(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return 1;
        }
        if n == 2 {
            return 1;
        }
        if n == 3 {
            return 2;
        }

        let mut s = vec![1, 0, 1, 2];
        let mut i = 2;
        let mut j = 3;
        while j < n as usize {
            let count = s[i];
            let val = if s[j - 1] == 1 { 2 } else { 1 };
            for _ in 0..count {
                s.push(val);
                j += 1;
                if j >= n as usize {
                    break;
                }
            }
            i += 1;
        }

        s[..n as usize].iter().filter(|&&x| x == 1).count() as i32
    }
}
}