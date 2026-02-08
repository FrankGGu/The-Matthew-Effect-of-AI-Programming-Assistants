struct Solution;

impl Solution {
    pub fn calculate_tax(brackets: Vec<Vec<i32>>, income: i32) -> f64 {
        let mut tax = 0.0;
        let mut prev = 0;
        for bracket in brackets {
            let level = bracket[0];
            let percent = bracket[1] as f64 / 100.0;
            let amount = (level - prev).max(0);
            if income <= prev {
                break;
            }
            tax += amount as f64 * percent;
            prev = level;
        }
        tax
    }
}