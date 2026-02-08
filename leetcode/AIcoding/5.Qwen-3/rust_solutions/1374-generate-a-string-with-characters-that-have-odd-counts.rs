impl Solution {

use std::char;

impl Solution {
    pub fn generate_the_string(n: i32) -> String {
        let mut result = String::new();
        let mut i = 0;
        while i < n {
            result.push('a');
            i += 1;
        }
        if n % 2 == 0 {
            result.pop();
            result.push('b');
        }
        result
    }
}
}