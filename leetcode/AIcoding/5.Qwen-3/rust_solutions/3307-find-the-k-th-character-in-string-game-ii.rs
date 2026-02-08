struct Solution;

impl Solution {
    pub fn kth_complex_number(n: i32, k: i32) -> String {
        let mut s = String::from("a");
        for _ in 0..n {
            let mut new_s = String::new();
            for c in s.chars() {
                match c {
                    'a' => new_s.push_str("ab"),
                    'b' => new_s.push_str("ba"),
                    _ => {}
                }
            }
            s = new_s;
        }
        let c = s.chars().nth(k as usize).unwrap();
        match c {
            'a' => "a".to_string(),
            'b' => "b".to_string(),
            _ => "a".to_string(),
        }
    }
}