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
            let node = Rc::clone(node);
            let val = node.borrow().value;
            self.remove_node(&node);
            self.add_to_head(&node);
            val
        } else {
            -1
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        if let Some(node) = self.cache.get(&key) {
            let node = Rc::clone(node);
            node.borrow_mut().value = value;
            self.remove_node(&node);
            self.add_to_head(&node);
        } else {
            let new_node = Rc::new(RefCell::new(Node {
                key,
                value,
                prev: None,
                next: None,
            }));
            self.cache.insert(key, Rc::clone(&new_node));
            self.add_to_head(&new_node);
            if self.cache.len() > self.capacity as usize {
                if let Some(tail) = self.tail.take() {
                    self.cache.remove(&tail.borrow().key);
                    self.remove_node(&tail);
                }
            }
        }
    }

    fn add_to_head(&mut self, node: &Rc<RefCell<Node>>) {
        let next = self.head.clone();
        node.borrow_mut().next = next.clone();
        node.borrow_mut().prev = None;
        if let Some(head) = self.head.as_ref() {
            head.borrow_mut().prev = Some(Rc::clone(node));
        }
        self.head = Some(Rc::clone(node));
        if self.tail.is_none() {
            self.tail = Some(Rc::clone(node));
        }
    }

    fn remove_node(&mut self, node: &Rc<RefCell<Node>>) {
        let prev = node.borrow().prev.clone();
        let next = node.borrow().next.clone();
        if let Some(prev) = prev {
            prev.borrow_mut().next = next.clone();
        } else {
            self.head = next.clone();
        }
        if let Some(next) = next {
            next.borrow_mut().prev = prev.clone();
        } else {
            self.tail = prev.clone();
        }
    }
}

struct Solution;

impl Solution {
    fn lru_cache(capacity: i32) -> LRUCache {
        LRUCache::new(capacity)
    }
}
}