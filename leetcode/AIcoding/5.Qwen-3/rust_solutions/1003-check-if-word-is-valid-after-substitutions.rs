struct Solution;

impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        for c in s.chars() {
            match c {
                'a' => stack.push(c),
                'b' => {
                    if stack.last() == Some(&'a') {
                        stack.pop();
                    } else {
                        return false;
                    }
                }
                'c' => {
                    if stack.last() == Some(&'b') {
                        stack.pop();
                        if stack.last() == Some(&'a') {
                            stack.pop();
                        } else {
                            return false;
                        }
                    } else {
                        return false;
                    }
                }
                _ => return false,
            }
        }
        stack.is_empty()
    }
}