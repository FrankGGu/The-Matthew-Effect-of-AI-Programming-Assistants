struct Solution {}

impl Solution {
    pub fn base_neg2(n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }
        let mut n = n;
        let mut res = Vec::new();
        while n != 0 {
            let remainder = n % (-2);
            n /= -2;
            if remainder < 0 {
                remainder += 2;
                n += 1;
            }
            res.push(remainder.to_string());
        }
        res.reverse();
        res.join("")
    }
}