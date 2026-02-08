struct Solution;

impl Solution {
    pub fn compute_area(
        ax1: i32,
        ay1: i32,
        ax2: i32,
        ay2: i32,
        bx1: i32,
        by1: i32,
        bx2: i32,
        by2: i32,
    ) -> i32 {
        let area1 = (ax2 - ax1) * (ay2 - ay1);
        let area2 = (bx2 - bx1) * (by2 - by1);

        let overlap_x = std::cmp::max(0, std::cmp::min(ax2, bx2) - std::cmp::max(ax1, bx1));
        let overlap_y = std::cmp::max(0, std::cmp::min(ay2, by2) - std::cmp::max(ay1, by1));

        let overlap_area = overlap_x * overlap_y;

        area1 + area2 - overlap_area
    }
}