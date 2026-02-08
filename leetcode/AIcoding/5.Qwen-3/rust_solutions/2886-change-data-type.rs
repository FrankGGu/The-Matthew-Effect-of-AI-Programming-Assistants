impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct DataFrame {
    pub data: HashMap<String, Vec<i32>>,
}

impl DataFrame {
    pub fn new(data: HashMap<String, Vec<i32>>) -> Self {
        DataFrame { data }
    }

    pub fn change_data_type(mut self, col_name: String, new_type: i32) -> Self {
        if let Some(values) = self.data.get_mut(&col_name) {
            for value in values {
                *value = new_type;
            }
        }
        self
    }
}
}