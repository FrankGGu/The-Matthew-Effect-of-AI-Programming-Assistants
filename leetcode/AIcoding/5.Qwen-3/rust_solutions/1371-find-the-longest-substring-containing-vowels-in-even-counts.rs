struct Solution;

impl Solution {
    pub fn find_longest_substring(s: String) -> i32 {
        let mut map = std::collections::HashMap::new();
        map.insert(0, -1);
        let mut max_len = 0;
        let mut state = 0;
        let vowels = ['a', 'e', 'i', 'o', 'u'];

        for (i, c) in s.chars().enumerate() {
            if let Some(idx) = vowels.iter().position(|&v| v == c) {
                state ^= 1 << idx;
            }

            if let Some(&prev) = map.get(&state) {
                max_len = std::cmp::max(max_len, i as i32 - prev);
            } else {
                map.insert(state, i as i32);
            }
        }

        max_len
    }
}