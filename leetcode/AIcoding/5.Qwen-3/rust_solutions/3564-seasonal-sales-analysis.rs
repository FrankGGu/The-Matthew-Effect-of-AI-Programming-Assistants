impl Solution {

use std::collections::HashMap;

fn main() {}

struct Solution;

impl Solution {
    pub fn seasonal_sales_analysis(sales: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut sales_map = HashMap::new();

        for sale in sales {
            let month = sale[0];
            let amount = sale[1];

            *sales_map.entry(month).or_insert(0) += amount;
        }

        let mut result: Vec<Vec<i32>> = sales_map.into_iter().map(|(k, v)| vec![k, v]).collect();
        result.sort_by_key(|x| x[0]);

        result
    }
}
}