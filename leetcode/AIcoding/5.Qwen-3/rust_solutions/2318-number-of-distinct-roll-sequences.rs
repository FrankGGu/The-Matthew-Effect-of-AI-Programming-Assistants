impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn distinct_sequences(target: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut result = 0;
        let target = target as usize;

        fn backtrack(
            current: &mut Vec<i32>,
            target: usize,
            seen: &mut HashSet<Vec<i32>>,
            result: &mut i32,
        ) {
            if current.len() == target {
                seen.insert(current.clone());
                *result += 1;
                return;
            }

            for i in 1..=6 {
                if current.is_empty() || (i != current[current.len() - 1] && i.abs_diff(current[current.len() - 1]) > 1) {
                    current.push(i);
                    backtrack(current, target, seen, result);
                    current.pop();
                }
            }
        }

        backtrack(&mut vec![], target, &mut seen, &mut result);
        result
    }
}
}