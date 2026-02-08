struct Solution;

impl Solution {
    pub fn count_k_constraint_substrings(s: String, k: i32) -> i32 {
        let mut count = 0;
        let s_bytes = s.as_bytes();
        let n = s.len();

        for i in 0..n {
            let mut ones = 0;
            let mut zeros = 0;
            for j in i..n {
                if s_bytes[j] == b'1' {
                    ones += 1;
                } else {
                    zeros += 1;
                }
                if ones <= k && zeros <= k {
                    count += 1;
                }
            }
        }

        count
    }
}