impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_anagrams(mut s: String, mut p: String) -> Vec<i32> {
        let len_s = s.len();
        let len_p = p.len();

        if len_s < len_p {
            return vec![];
        }

        let mut count = HashMap::new();
        for c in p.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut window = HashMap::new();
        for i in 0..len_p {
            let c = s.chars().nth(i).unwrap();
            *window.entry(c).or_insert(0) += 1;
        }

        let mut result = vec![];
        if window == count {
            result.push(0);
        }

        for i in len_p..len_s {
            let out = s.chars().nth(i - len_p).unwrap();
            let in_c = s.chars().nth(i).unwrap();

            *window.entry(out).or_insert(0) -= 1;
            if *window.get(&out).unwrap() == 0 {
                window.remove(&out);
            }

            *window.entry(in_c).or_insert(0) += 1;

            if window == count {
                result.push((i - len_p + 1) as i32);
            }
        }

        result
    }
}
}