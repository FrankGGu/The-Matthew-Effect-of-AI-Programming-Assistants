impl Solution {

use std::collections::HashMap;

struct Robot {
    x: i32,
    y: i32,
    dir: i32,
    obstacles: HashMap<(i32, i32), bool>,
}

impl Robot {
    fn new(width: i32, height: i32, robot_position: Vec<i32>, obstacles: Vec<Vec<i32>>) -> Self {
        let x = robot_position[0];
        let y = robot_position[1];
        let dir = 0; // 0: north, 1: east, 2: south, 3: west
        let mut obstacles_map = HashMap::new();
        for ob in obstacles {
            obstacles_map.insert((ob[0], ob[1]), true);
        }
        Robot { x, y, dir, obstacles: obstacles_map }
    }

    fn move_forward(&mut self, steps: i32) {
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let (dx, dy) = directions[self.dir as usize];

        for _ in 0..steps {
            let next_x = self.x + dx;
            let next_y = self.y + dy;

            if self.obstacles.contains_key(&(next_x, next_y)) {
                break;
            }

            self.x = next_x;
            self.y = next_y;
        }
    }

    fn turn_left(&mut self) {
        self.dir = (self.dir + 3) % 4;
    }

    fn turn_right(&mut self) {
        self.dir = (self.dir + 1) % 4;
    }

    fn get_position(&self) -> Vec<i32> {
        vec![self.x, self.y]
    }

    fn get_dir(&self) -> i32 {
        self.dir
    }
}

struct Solution {}

impl Solution {
    pub fn robot_sim(mut instructions: String, width: i32, height: i32, robot_position: Vec<i32>, obstacles: Vec<Vec<i32>>) -> Vec<i32> {
        let mut robot = Robot::new(width, height, robot_position, obstacles);
        let directions = ['L', 'R'];

        for c in instructions.chars() {
            if c == 'L' {
                robot.turn_left();
            } else if c == 'R' {
                robot.turn_right();
            } else {
                let steps = c.to_digit(10).unwrap() as i32;
                robot.move_forward(steps);
            }
        }

        robot.get_position()
    }
}
}