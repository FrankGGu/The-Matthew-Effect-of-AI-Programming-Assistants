struct Solution;

impl Solution {
    pub fn remove_duplicates(s: String, k: i32) -> String {
        let mut stack = Vec::new();
        let k = k as usize;

        for c in s.chars() {
            if let Some((last_char, count)) = stack.last_mut() {
                if *last_char == c {
                    *count += 1;
                    if *count == k {
                        stack.pop();
                    }
                } else {
                    stack.push((c, 1));
                }
            } else {
                stack.push((c, 1));
            }
        }

        let mut result = String::new();
        for (c, count) in stack {
            result.extend(std::iter::repeat(c).take(count));
        }

        result
    }
}