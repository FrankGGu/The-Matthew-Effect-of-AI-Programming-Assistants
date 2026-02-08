impl Solution {
    pub fn game_of_life(board: &mut Vec<Vec<i32>>) {
        let m = board.len();
        let n = board[0].len();

        for i in 0..m {
            for j in 0..n {
                let mut live_neighbors = 0;

                for x in [i-1, i, i+1].iter() {
                    for y in [j-1, j, j+1].iter() {
                        if *x < 0 || *x >= m || *y < 0 || *y >= n {
                            continue;
                        }
                        if *x == i && *y == j {
                            continue;
                        }
                        if board[*x][*y] == 1 || board[*x][*y] == 3 {
                            live_neighbors += 1;
                        }
                    }
                }

                if board[i][j] == 1 && (live_neighbors < 2 || live_neighbors > 3) {
                    board[i][j] = 3;
                } else if board[i][j] == 0 && live_neighbors == 3 {
                    board[i][j] = 2;
                }
            }
        }

        for i in 0..m {
            for j in 0..n {
                if board[i][j] == 2 {
                    board[i][j] = 1;
                } else if board[i][j] == 3 {
                    board[i][j] = 0;
                }
            }
        }
    }
}