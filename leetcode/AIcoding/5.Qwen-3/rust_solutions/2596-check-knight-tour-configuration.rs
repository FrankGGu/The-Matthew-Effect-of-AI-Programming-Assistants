struct Solution;

impl Solution {
    pub fn is_knight_tour(tour: Vec<Vec<i32>>) -> bool {
        let n = tour.len();
        if n == 0 {
            return true;
        }
        let mut visited = vec![vec![false; n]; n];
        let directions = [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (1, -2), (1, 2), (2, -1), (2, 1)];

        let start_row = tour[0][0] as usize;
        let start_col = tour[0][1] as usize;
        visited[start_row][start_col] = true;

        for i in 1..tour.len() {
            let curr_row = tour[i][0] as usize;
            let curr_col = tour[i][1] as usize;
            let prev_row = tour[i-1][0] as usize;
            let prev_col = tour[i-1][1] as usize;

            if !visited[curr_row][curr_col] {
                for &(dr, dc) in &directions {
                    let r = prev_row as i32 + dr;
                    let c = prev_col as i32 + dc;
                    if r == curr_row as i32 && c == curr_col as i32 {
                        visited[curr_row][curr_col] = true;
                        break;
                    }
                }
            } else {
                return false;
            }
        }

        for row in 0..n {
            for col in 0..n {
                if !visited[row][col] {
                    return false;
                }
            }
        }

        true
    }
}