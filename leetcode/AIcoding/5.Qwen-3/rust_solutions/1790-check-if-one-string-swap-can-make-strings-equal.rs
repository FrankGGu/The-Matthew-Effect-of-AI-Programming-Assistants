struct Solution;

impl Solution {
    pub fn are_almost_equal(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut diff = Vec::new();

        for (i, (a, b)) in s.chars().zip(t.chars()).enumerate() {
            if a != b {
                diff.push(i);
                if diff.len() > 2 {
                    return false;
                }
            }
        }

        diff.len() == 2 && s.chars().nth(diff[0]) == t.chars().nth(diff[1]) && s.chars().nth(diff[1]) == t.chars().nth(diff[0])
    }
}