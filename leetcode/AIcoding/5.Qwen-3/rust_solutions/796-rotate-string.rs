impl Solution {
    pub fn rotate_string(a: String, b: String) -> bool {
        if a.len() != b.len() {
            return false;
        }
        let combined = format!("{}{}", a, a);
        combined.contains(&b)
    }
}