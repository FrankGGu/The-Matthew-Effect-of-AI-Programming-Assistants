impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_shortest_way(maze: Vec<Vec<i32>>, ball: Vec<i32>, hole: Vec<i32>) -> String {
        let rows = maze.len();
        let cols = maze[0].len();
        let directions = vec![("down", 1, 0), ("up", -1, 0), ("right", 0, 1), ("left", 0, -1)];

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        let start = (ball[0] as usize, ball[1] as usize);
        let hole = (hole[0] as usize, hole[1] as usize);

        queue.push_back((start.0, start.1, String::new(), 0));
        visited.insert((start.0, start.1));

        while let Some((r, c, path, steps)) = queue.pop_front() {
            if (r, c) == hole {
                return path;
            }

            for (dir, dr, dc) in &directions {
                let mut nr = r;
                let mut nc = c;
                let mut dist = 0;

                while nr as i32 + *dr >= 0 && nr as i32 + *dr < rows as i32 && nc as i32 + *dc >= 0 && nc as i32 + *dc < cols as i32 && maze[nr + *dr as usize][nc + *dc as usize] == 0 {
                    nr += *dr as usize;
                    nc += *dc as usize;
                    dist += 1;

                    if (nr, nc) == hole {
                        break;
                    }
                }

                if (nr, nc) != (r, c) && !visited.contains(&(nr, nc)) {
                    visited.insert((nr, nc));
                    let new_path = format!("{}{}", path, dir);
                    queue.push_back((nr, nc, new_path, steps + dist));
                }
            }
        }

        String::new()
    }
}
}