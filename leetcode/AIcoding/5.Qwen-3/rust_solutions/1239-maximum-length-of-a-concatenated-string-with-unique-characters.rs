impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_length(mut arr: Vec<String>) -> i32 {
        arr.retain(|s| {
            let mut set = HashSet::new();
            for c in s.chars() {
                if !set.insert(c) {
                    return false;
                }
            }
            true
        });

        fn backtrack(index: usize, current: &HashSet<char>, arr: &[String]) -> i32 {
            if index == arr.len() {
                return current.len() as i32;
            }

            let mut max_len = 0;

            let mut new_set = current.clone();
            let mut valid = true;
            for c in arr[index].chars() {
                if !new_set.insert(c) {
                    valid = false;
                    break;
                }
            }

            if valid {
                max_len = backtrack(index + 1, &new_set, arr);
            }

            max_len = std::cmp::max(max_len, backtrack(index + 1, current, arr));

            max_len
        }

        backtrack(0, &HashSet::new(), &arr)
    }
}
}