struct Solution;

impl Solution {
    pub fn inventory_management(warehouse: Vec<i32>, cnt: i32) -> i32 {
        let mut warehouse = warehouse;
        warehouse.sort();
        warehouse[cnt as usize]
    }
}