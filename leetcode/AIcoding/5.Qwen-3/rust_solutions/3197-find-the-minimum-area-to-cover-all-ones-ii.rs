struct Solution {}

impl Solution {
    pub fn minimum_square_area(ones: Vec<Vec<i32>>) -> i32 {
        let mut min_row = i32::MAX;
        let mut max_row = i32::MIN;
        let mut min_col = i32::MAX;
        let mut max_col = i32::MIN;

        for (i, row) in ones.iter().enumerate() {
            for (j, &val) in row.iter().enumerate() {
                if val == 1 {
                    min_row = min_row.min(i as i32);
                    max_row = max_row.max(i as i32);
                    min_col = min_col.min(j as i32);
                    max_col = max_col.max(j as i32);
                }
            }
        }

        let height = max_row - min_row + 1;
        let width = max_col - min_col + 1;
        let side = std::cmp::max(height, width);
        side * side
    }
}