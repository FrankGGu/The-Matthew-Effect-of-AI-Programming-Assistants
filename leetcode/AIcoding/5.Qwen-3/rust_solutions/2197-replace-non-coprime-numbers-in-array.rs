impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn replace_non_coprime_numbers(mut nums: Vec<i32>) -> Vec<i32> {
        let mut stack = VecDeque::new();

        for num in nums {
            let mut current = num;
            while let Some(top) = stack.back() {
                let gcd = Self::gcd(*top, current);
                if gcd == 1 {
                    break;
                }
                current = current / gcd * *top;
                stack.pop_back();
            }
            stack.push_back(current);
        }

        stack.into_iter().collect()
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}