struct Solution;

impl Solution {
    pub fn convert(s: String, num_rows: i32) -> String {
        if num_rows == 1 || s.len() <= num_rows as usize {
            return s;
        }

        let mut result = String::with_capacity(s.len());
        let step = 2 * num_rows - 2;

        for i in 0..num_rows {
            let mut j = i as usize;
            while j < s.len() {
                result.push(s.chars().nth(j).unwrap());
                if i != 0 && i != num_rows - 1 && j + step - 2 * i < s.len() {
                    result.push(s.chars().nth(j + step - 2 * i).unwrap());
                }
                j += step;
            }
        }

        result
    }
}