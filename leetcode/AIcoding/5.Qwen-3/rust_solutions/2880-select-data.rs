impl Solution {

use std::collections::HashMap;

fn main() {}

#[derive(Debug, PartialEq, Eq)]
pub struct DataFrame {
    pub data: Vec<Vec<String>>,
    pub columns: Vec<String>,
}

pub fn select_data(df: &DataFrame) -> Vec<Vec<String>> {
    df.data.clone()
}
}