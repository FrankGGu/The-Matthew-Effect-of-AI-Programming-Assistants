struct Solution;

impl Solution {
    pub fn tictactoe(moves: Vec<Vec<i32>>) -> String {
        let mut board = [[0; 3]; 3];
        for (i, move_coords) in moves.iter().enumerate() {
            let row = move_coords[0] as usize;
            let col = move_coords[1] as usize;
            if i % 2 == 0 {
                board[row][col] = 1;
            } else {
                board[row][col] = 2;
            }
        }

        for player in [1, 2] {
            for i in 0..3 {
                if board[i][0] == player && board[i][1] == player && board[i][2] == player {
                    return match player {
                        1 => "A".to_string(),
                        _ => "B".to_string(),
                    };
                }
                if board[0][i] == player && board[1][i] == player && board[2][i] == player {
                    return match player {
                        1 => "A".to_string(),
                        _ => "B".to_string(),
                    };
                }
            }
            if board[0][0] == player && board[1][1] == player && board[2][2] == player {
                return match player {
                    1 => "A".to_string(),
                    _ => "B".to_string(),
                };
            }
            if board[0][2] == player && board[1][1] == player && board[2][0] == player {
                return match player {
                    1 => "A".to_string(),
                    _ => "B".to_string(),
                };
            }
        }

        if moves.len() == 9 {
            "Draw".to_string()
        } else {
            "Pending".to_string()
        }
    }
}