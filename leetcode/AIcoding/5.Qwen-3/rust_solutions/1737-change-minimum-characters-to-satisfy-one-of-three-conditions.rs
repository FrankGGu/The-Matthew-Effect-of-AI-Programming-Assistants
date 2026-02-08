impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_changes_to_satisfy_condition(a: String, b: String) -> i32 {
        fn count_chars(s: &str) -> HashMap<char, i32> {
            let mut map = HashMap::new();
            for c in s.chars() {
                *map.entry(c).or_insert(0) += 1;
            }
            map
        }

        let a_count = count_chars(&a);
        let b_count = count_chars(&b);

        let mut res = i32::MAX;

        // Condition 1: a has more of each character than b
        let mut cnt1 = 0;
        for c in 'a'..='z' {
            let a_c = *a_count.get(&c).unwrap_or(&0);
            let b_c = *b_count.get(&c).unwrap_or(&0);
            if a_c <= b_c {
                cnt1 += b_c - a_c;
            }
        }
        res = res.min(cnt1);

        // Condition 2: b has more of each character than a
        let mut cnt2 = 0;
        for c in 'a'..='z' {
            let a_c = *a_count.get(&c).unwrap_or(&0);
            let b_c = *b_count.get(&c).unwrap_or(&0);
            if b_c <= a_c {
                cnt2 += a_c - b_c;
            }
        }
        res = res.min(cnt2);

        // Condition 3: a and b have the same number of each character
        let mut cnt3 = 0;
        for c in 'a'..='z' {
            let a_c = *a_count.get(&c).unwrap_or(&0);
            let b_c = *b_count.get(&c).unwrap_or(&0);
            if a_c != b_c {
                cnt3 += (a_c - b_c).abs();
            }
        }
        res = res.min(cnt3);

        res
    }
}
}