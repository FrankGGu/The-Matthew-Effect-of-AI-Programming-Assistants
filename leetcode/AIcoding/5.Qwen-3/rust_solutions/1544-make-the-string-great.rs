struct Solution;

impl Solution {
    pub fn remove_adjacent_duplicates(s: String) -> String {
        let mut stack = Vec::new();
        for c in s.chars() {
            if let Some(&last) = stack.last() {
                if last != c {
                    stack.push(c);
                } else {
                    stack.pop();
                }
            } else {
                stack.push(c);
            }
        }
        stack.into_iter().collect()
    }
}