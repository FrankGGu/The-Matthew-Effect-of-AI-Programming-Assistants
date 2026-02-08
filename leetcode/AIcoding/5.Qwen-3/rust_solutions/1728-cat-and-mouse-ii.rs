impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn can_mouse_win(mut grid: Vec<Vec<char>>, cat_jump: i32, mouse_jump: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut mouse_pos = (0, 0);
        let mut cat_pos = (0, 0);
        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 'M' {
                    mouse_pos = (i, j);
                } else if grid[i][j] == 'C' {
                    cat_pos = (i, j);
                }
            }
        }

        let mut state = vec![vec![vec![vec![false; 2]; n]; m]; m * n];
        let mut queue = VecDeque::new();
        let mut degrees = vec![vec![vec![vec![0; 2]; n]; m]; m * n];

        for i in 0..m {
            for j in 0..n {
                for k in 0..m {
                    for l in 0..n {
                        for turn in 0..2 {
                            let is_mouse_turn = turn == 0;
                            let (x, y) = if is_mouse_turn { (i, j) } else { (k, l) };
                            if grid[x][y] == 'F' {
                                state[i][j][k][l][turn] = true;
                                queue.push_back((i, j, k, l, turn));
                            } else {
                                let mut cnt = 0;
                                for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                                    let mut nx = x;
                                    let mut ny = y;
                                    for _ in 0..(if is_mouse_turn { mouse_jump } else { cat_jump }) {
                                        nx = nx.wrapping_add(*dx as isize);
                                        ny = ny.wrapping_add(*dy as isize);
                                        if nx < 0 || ny < 0 || nx >= m as isize || ny >= n as isize || grid[nx as usize][ny as usize] == 'W' {
                                            break;
                                        }
                                    }
                                    if nx < 0 || ny < 0 || nx >= m as isize || ny >= n as isize || grid[nx as usize][ny as usize] == 'W' {
                                        continue;
                                    }
                                    if is_mouse_turn {
                                        cnt += 1;
                                        degrees[i][j][k][l][turn] += 1;
                                    } else {
                                        cnt += 1;
                                        degrees[k][l][i][j][turn] += 1;
                                    }
                                }
                                if cnt == 0 {
                                    state[i][j][k][l][turn] = !is_mouse_turn;
                                    queue.push_back((i, j, k, l, turn));
                                }
                            }
                        }
                    }
                }
            }
        }

        while let Some((i, j, k, l, turn)) = queue.pop_front() {
            if turn == 0 {
                for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let mut ni = i;
                    let mut nj = j;
                    for _ in 0..mouse_jump {
                        ni = ni.wrapping_add(*dx as isize);
                        nj = nj.wrapping_add(*dy as isize);
                        if ni < 0 || nj < 0 || ni >= m as isize || nj >= n as isize || grid[ni as usize][nj as usize] == 'W' {
                            break;
                        }
                    }
                    if ni < 0 || nj < 0 || ni >= m as isize || nj >= n as usize || grid[ni as usize][nj as usize] == 'W' {
                        continue;
                    }
                    if !state[ni as usize][nj as usize][k][l][1] {
                        if state[i][j][k][l][turn] {
                            state[ni as usize][nj as usize][k][l][1] = true;
                            queue.push_back((ni as usize, nj as usize, k, l, 1));
                        } else {
                            degrees[ni as usize][nj as usize][k][l][1] -= 1;
                            if degrees[ni as usize][nj as usize][k][l][1] == 0 {
                                state[ni as usize][nj as usize][k][l][1] = false;
                                queue.push_back((ni as usize, nj as usize, k, l, 1));
                            }
                        }
                    }
                }
            } else {
                for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let mut nk = k;
                    let mut nl = l;
                    for _ in 0..cat_jump {
                        nk = nk.wrapping_add(*dx as isize);
                        nl = nl.wrapping_add(*dy as isize);
                        if nk < 0 || nl < 0 || nk >= m as isize || nl >= n as isize || grid[nk as usize][nl as usize] == 'W' {
                            break;
                        }
                    }
                    if nk < 0 || nl < 0 || nk >= m as isize || nl >= n as usize || grid[nk as usize][nl as usize] == 'W' {
                        continue;
                    }
                    if !state[i][j][nk as usize][nl as usize][0] {
                        if state[i][j][k][l][turn] {
                            state[i][j][nk as usize][nl as usize][0] = true;
                            queue.push_back((i, j, nk as usize, nl as usize, 0));
                        } else {
                            degrees[i][j][nk as usize][nl as usize][0] -= 1;
                            if degrees[i][j][nk as usize][nl as usize][0] == 0 {
                                state[i][j][nk as usize][nl as usize][0] = false;
                                queue.push_back((i, j, nk as usize, nl as usize, 0));
                            }
                        }
                    }
                }
            }
        }

        return state[mouse_pos.0][mouse_pos.1][cat_pos.0][cat_pos.1][0];
    }
}

struct Solution;
}