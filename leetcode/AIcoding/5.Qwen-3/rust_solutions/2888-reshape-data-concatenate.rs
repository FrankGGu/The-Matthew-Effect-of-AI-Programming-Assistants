impl Solution {

use std::vec;

#[derive(Debug, Clone, PartialEq)]
struct DataFrame {
    pub students: Vec<Vec<String>>,
}

impl DataFrame {
    pub fn new(students: Vec<Vec<String>>) -> Self {
        DataFrame { students }
    }
}

fn concatenate_arrays(arr1: Vec<Vec<String>>, arr2: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut result = vec![];
    result.extend(arr1);
    result.extend(arr2);
    result
}

pub fn concatenate_data(df1: DataFrame, df2: DataFrame) -> DataFrame {
    let students = concatenate_arrays(df1.students, df2.students);
    DataFrame::new(students)
}
}