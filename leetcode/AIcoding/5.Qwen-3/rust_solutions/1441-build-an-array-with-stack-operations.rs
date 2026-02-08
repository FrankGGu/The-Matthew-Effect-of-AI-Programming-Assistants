struct Solution;

impl Solution {
    pub fn build_array(target: Vec<i32>, n: i32) -> Vec<String> {
        let mut result = Vec::new();
        let mut current = 1;

        for &num in &target {
            while current < num {
                result.push("Push".to_string());
                result.push("Pop".to_string());
                current += 1;
            }
            result.push("Push".to_string());
            current += 1;
        }

        result
    }
}