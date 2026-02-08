impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn num_special_equivalent(mut strings: Vec<String>) -> i32 {
        let mut set = HashSet::new();

        for s in &mut strings {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort_by(|a, b| a.cmp(b));

            let mut even = String::new();
            let mut odd = String::new();

            for (i, c) in chars.iter().enumerate() {
                if i % 2 == 0 {
                    even.push(*c);
                } else {
                    odd.push(*c);
                }
            }

            set.insert(even + &odd);
        }

        set.len() as i32
    }
}
}