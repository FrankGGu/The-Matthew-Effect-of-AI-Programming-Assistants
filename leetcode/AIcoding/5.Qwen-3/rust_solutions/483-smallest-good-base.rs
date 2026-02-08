impl Solution {

use std::str::FromStr;

struct Solution;

impl Solution {
    pub fn get_least_num(n: i64) -> String {
        let n = n as u64;
        for k in 2..=n {
            let mut sum = 0;
            let mut base = 1;
            while sum < n {
                sum += base;
                base *= k;
            }
            if sum == n {
                return k.to_string();
            }
        }
        n.to_string()
    }
}

fn main() {
    let input = std::io::stdin().lines().next().unwrap().unwrap();
    let n = i64::from_str(&input).unwrap();
    println!("{}", Solution::get_least_num(n));
}
}