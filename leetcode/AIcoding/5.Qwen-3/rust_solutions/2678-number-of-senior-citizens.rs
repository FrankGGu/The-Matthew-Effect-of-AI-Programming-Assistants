struct Solution;

impl Solution {
    pub fn number_of_senior_citizens(details: Vec<String>) -> i32 {
        details
            .into_iter()
            .filter(|d| {
                let age_str = &d[11..13];
                let age: i32 = age_str.parse().unwrap();
                age > 60
            })
            .count() as i32
    }
}