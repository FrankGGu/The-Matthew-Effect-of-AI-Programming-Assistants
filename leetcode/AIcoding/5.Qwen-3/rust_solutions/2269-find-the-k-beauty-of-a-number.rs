struct Solution;

impl Solution {
    pub fn divisor_substrings(n: i32, k: i32) -> i32 {
        let s = n.to_string();
        let k = k as usize;
        let len = s.len();
        let mut count = 0;

        for i in 0..=len - k {
            let substring = &s[i..i + k];
            let num = substring.parse::<i32>().unwrap();
            if n % num == 0 {
                count += 1;
            }
        }

        count
    }
}