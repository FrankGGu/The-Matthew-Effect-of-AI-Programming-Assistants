struct Solution;

impl Solution {
    pub fn maximum_swap(mut num: i32) -> i32 {
        let mut digits = num.to_string().chars().collect::<Vec<char>>();
        let mut last_index = std::collections::HashMap::new();

        for (i, &c) in digits.iter().enumerate() {
            last_index.insert(c, i);
        }

        for (i, &c) in digits.iter().enumerate() {
            let max_digit = (b'9' as char..=c).rev().find(|&d| last_index.get(&d).unwrap() > &i);
            if let Some(max_digit) = max_digit {
                let j = *last_index.get(&max_digit).unwrap();
                digits.swap(i, j);
                return digits.into_iter().collect::<String>().parse().unwrap();
            }
        }

        num
    }
}