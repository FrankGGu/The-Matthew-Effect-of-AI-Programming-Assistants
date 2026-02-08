impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_possible_integer(mut num: String, k: i32) -> String {
        let k = k as usize;
        let mut digits = num.chars().collect::<Vec<_>>();
        let n = digits.len();

        for i in 0..n {
            if k == 0 {
                break;
            }
            let mut min_pos = i;
            for j in i + 1..n {
                if digits[j] < digits[min_pos] {
                    min_pos = j;
                }
            }
            for j in min_pos..i {
                digits.swap(j, j + 1);
                k -= 1;
                if k == 0 {
                    break;
                }
            }
        }

        digits.into_iter().collect()
    }
}
}