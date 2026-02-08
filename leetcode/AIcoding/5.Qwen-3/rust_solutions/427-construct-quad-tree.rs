impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
enum Node {
    Leaf(bool),
    Node(bool, Vec<Node>),
}

impl Node {
    fn new_leaf(val: bool) -> Self {
        Node::Leaf(val)
    }

    fn new_node(val: bool, children: Vec<Node>) -> Self {
        Node::Node(val, children)
    }
}

struct Solution;

impl Solution {
    pub fn construct(grid: Vec<Vec<i32>>) -> Option<Rc<RefCell<Node>>> {
        fn build(grid: &Vec<Vec<i32>>, x: i32, y: i32, size: i32) -> Node {
            if size == 1 {
                return Node::Leaf(grid[x as usize][y as usize] == 1);
            }

            let half = size / 2;
            let top_left = build(grid, x, y, half);
            let top_right = build(grid, x, y + half, half);
            let bottom_left = build(grid, x + half, y, half);
            let bottom_right = build(grid, x + half, y + half, half);

            let is_same = match (&top_left, &top_right, &bottom_left, &bottom_right) {
                (Node::Leaf(v1), Node::Leaf(v2), Node::Leaf(v3), Node::Leaf(v4)) => v1 == v2 && v2 == v3 && v3 == v4,
                _ => false,
            };

            if is_same {
                Node::Leaf(*match top_left {
                    Node::Leaf(v) => v,
                    _ => false,
                })
            } else {
                Node::Node(false, vec![top_left, top_right, bottom_left, bottom_right])
            }
        }

        let n = grid.len();
        if n == 0 {
            return None;
        }

        Some(Rc::new(RefCell::new(build(&grid, 0, 0, n as i32))))
    }
}
}