pub fn min_deletion_rows(mut grid: Vec<Vec<char>>) -> i32 {
    let rows = grid.len();
    let cols = grid[0].len();
    let mut result = 0;

    for c in 0..cols {
        for r in 1..rows {
            if grid[r][c] < grid[r - 1][c] {
                result += 1;
                break;
            }
        }
    }

    result
}