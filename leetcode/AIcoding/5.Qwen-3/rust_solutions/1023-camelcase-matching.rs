struct Solution;

impl Solution {
    pub fn camel_match(queries: Vec<String>, pattern: String) -> Vec<bool> {
        let mut result = Vec::new();
        for query in queries {
            result.push(Self::is_match(&query, &pattern));
        }
        result
    }

    fn is_match(query: &str, pattern: &str) -> bool {
        let mut p = 0;
        for c in query.chars() {
            if p < pattern.len() && c == pattern.chars().nth(p).unwrap() {
                p += 1;
            } else if c.is_uppercase() {
                return false;
            }
        }
        p == pattern.len()
    }
}