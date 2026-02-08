impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn find_content_children(g: Vec<i32>, s: Vec<i32>) -> i32 {
        let mut g = g;
        let mut s = s;
        g.sort();
        s.sort();

        let mut i = 0;
        let mut j = 0;

        while i < g.len() && j < s.len() {
            match g[i].cmp(&s[j]) {
                Ordering::Less => i += 1,
                _ => {
                    i += 1;
                    j += 1;
                }
            }
        }

        j as i32
    }
}
}