struct Solution;

impl Solution {
    pub fn minimum_square_area(boxes: Vec<Vec<i32>>) -> i32 {
        let mut min_x = i32::MAX;
        let mut max_x = i32::MIN;
        let mut min_y = i32::MAX;
        let mut max_y = i32::MIN;

        for box_coords in boxes {
            let x = box_coords[0];
            let y = box_coords[1];
            min_x = min_x.min(x);
            max_x = max_x.max(x);
            min_y = min_y.min(y);
            max_y = max_y.max(y);
        }

        let width = max_x - min_x;
        let height = max_y - min_y;
        let side = width.max(height);

        (side + 1) * (side + 1)
    }
}