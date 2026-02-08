impl Solution {
    pub fn check_almost_equal(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        let mut count = 0;
        for (a, b) in s.chars().zip(goal.chars()) {
            if a != b {
                count += 1;
                if count > 2 {
                    return false;
                }
            }
        }
        count <= 2
    }
}