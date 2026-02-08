impl Solution {

use std::collections::HashMap;

fn create_dataframe(names: Vec<String>, ages: Vec<i32>) -> HashMap<String, Vec<i32>> {
    let mut df = HashMap::new();
    df.insert("name".to_string(), names.into_iter().map(|s| s.parse::<i32>().unwrap()).collect());
    df.insert("age".to_string(), ages);
    df
}
}