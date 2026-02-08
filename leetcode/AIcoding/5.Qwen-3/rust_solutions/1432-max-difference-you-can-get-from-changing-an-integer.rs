struct Solution;

impl Solution {
    pub fn min_max_diff(mut num: i32) -> i32 {
        let s = num.to_string();
        let mut min_val = num;
        let mut max_val = num;

        for c in '0'..='9' {
            let mut new_num = String::new();
            let mut replaced = false;
            for ch in s.chars() {
                if !replaced && ch != c {
                    new_num.push(c);
                    replaced = true;
                } else {
                    new_num.push(ch);
                }
            }
            if let Ok(n) = new_num.parse::<i32>() {
                min_val = min_val.min(n);
                max_val = max_val.max(n);
            }
        }

        max_val - min_val
    }
}