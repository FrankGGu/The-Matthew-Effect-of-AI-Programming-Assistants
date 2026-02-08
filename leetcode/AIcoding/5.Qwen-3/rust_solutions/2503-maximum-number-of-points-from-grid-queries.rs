impl Solution {

use std::collections::{BinaryHeap, VecDeque};

impl Solution {
    pub fn max_points(grid: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut sorted_queries: Vec<(i32, usize)> = queries.iter().enumerate().map(|(i, &q)| (q, i)).collect();
        sorted_queries.sort();

        let mut result = vec![0; queries.len()];
        let mut heap = BinaryHeap::new();
        let mut visited = vec![vec![false; grid[0].size()]; grid.size()];

        for &(q, idx) in &sorted_queries {
            while !heap.is_empty() && heap.peek().unwrap().0 < q {
                let (val, x, y) = heap.pop().unwrap();
                if val >= q {
                    heap.push((val, x, y));
                    break;
                }
            }

            if grid[0][0] >= q && !visited[0][0] {
                heap.push((grid[0][0], 0, 0));
                visited[0][0] = true;
            }

            let mut points = 0;
            let mut queue = VecDeque::new();
            let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

            while let Some((x, y)) = queue.pop_front() {
                for &(dx, dy) in &directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 && !visited[nx as usize][ny as usize] {
                        visited[nx as usize][ny as usize] = true;
                        if grid[nx as usize][ny as usize] >= q {
                            heap.push((grid[nx as usize][ny as usize], nx as usize, ny as usize));
                        } else {
                            queue.push((nx as usize, ny as usize));
                        }
                    }
                }
            }

            while let Some((val, x, y)) = heap.pop() {
                points += 1;
                for &(dx, dy) in &directions {
                    let nx = x as i32 + dx;
                    let ny = y as i32 + dy;
                    if nx >= 0 && ny >= 0 && nx < grid.len() as i32 && ny < grid[0].len() as i32 && !visited[nx as usize][ny as usize] {
                        visited[nx as usize][ny as usize] = true;
                        if grid[nx as usize][ny as usize] >= q {
                            heap.push((grid[nx as usize][ny as usize], nx as usize, ny as usize));
                        } else {
                            queue.push((nx as usize, ny as usize));
                        }
                    }
                }
            }

            result[idx] = points;
        }

        result
    }
}
}