impl Solution {

use std::collections::HashMap;
use std::cell::RefCell;
use std::rc::Rc;

struct LRUCache {
    capacity: i32,
    cache: HashMap<i32, Rc<RefCell<Node>>>,
    head: Option<Rc<RefCell<Node>>>,
    tail: Option<Rc<RefCell<Node>>>,
}

struct Node {
    key: i32,
    value: i32,
    prev: Option<Rc<RefCell<Node>>>,
    next: Option<Rc<RefCell<Node>>>,
}

impl LRUCache {
    fn new(capacity: i32) -> Self {
        LRUCache {
            capacity,
            cache: HashMap::new(),
            head: None,
            tail: None,
        }
    }

    fn get(&mut self, key: i32) -> i32 {
        if let Some(node) = self.cache.get(&key) {
            let node_ref = node.clone();
            let mut node_mut = node_ref.borrow_mut();

            if let Some(prev) = &node_mut.prev {
                let mut prev_mut = prev.borrow_mut();
                prev_mut.next = node_mut.next.clone();
                if let Some(next) = &node_mut.next {
                    let mut next_mut = next.borrow_mut();
                    next_mut.prev = node_mut.prev.clone();
                } else {
                    self.tail = node_mut.prev.clone();
                }

                node_mut.prev = None;
                node_mut.next = self.head.clone();

                if let Some(head) = &self.head {
                    let mut head_mut = head.borrow_mut();
                    head_mut.prev = Some(node_ref.clone());
                }

                self.head = Some(node_ref.clone());
            }

            return node_mut.value;
        }

        -1
    }

    fn put(&mut self, key: i32, value: i32) {
        if let Some(node) = self.cache.get(&key) {
            let node_ref = node.clone();
            let mut node_mut = node_ref.borrow_mut();
            node_mut.value = value;

            if let Some(prev) = &node_mut.prev {
                let mut prev_mut = prev.borrow_mut();
                prev_mut.next = node_mut.next.clone();
                if let Some(next) = &node_mut.next {
                    let mut next_mut = next.borrow_mut();
                    next_mut.prev = node_mut.prev.clone();
                } else {
                    self.tail = node_mut.prev.clone();
                }

                node_mut.prev = None;
                node_mut.next = self.head.clone();

                if let Some(head) = &self.head {
                    let mut head_mut = head.borrow_mut();
                    head_mut.prev = Some(node_ref.clone());
                }

                self.head = Some(node_ref.clone());
            }
            return;
        }

        let new_node = Rc::new(RefCell::new(Node {
            key,
            value,
            prev: None,
            next: None,
        }));

        if self.cache.len() >= self.capacity as usize {
            if let Some(tail) = &self.tail {
                let mut tail_mut = tail.borrow_mut();
                let key_to_remove = tail_mut.key;
                self.cache.remove(&key_to_remove);

                if let Some(prev) = &tail_mut.prev {
                    let mut prev_mut = prev.borrow_mut();
                    prev_mut.next = None;
                    self.tail = Some(prev.clone());
                } else {
                    self.head = None;
                    self.tail = None;
                }
            }
        }

        new_node.borrow_mut().next = self.head.clone();
        if let Some(head) = &self.head {
            let mut head_mut = head.borrow_mut();
            head_mut.prev = Some(new_node.clone());
        }

        self.head = Some(new_node.clone());
        self.cache.insert(key, new_node);
    }
}

struct Solution;

impl Solution {
    fn lru_cache(capacity: i32) -> LRUCache {
        LRUCache::new(capacity)
    }
}
}