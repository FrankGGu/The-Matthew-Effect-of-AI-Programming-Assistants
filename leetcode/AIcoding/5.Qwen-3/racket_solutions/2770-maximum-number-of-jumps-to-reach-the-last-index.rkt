#lang racket

(define/contract (jump-game nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [jumps 0] [max-reach 0])
    (cond
      [(= i (length nums)) jumps]
      [(> i max-reach) -1]
      [else (loop (+ i 1) (+ jumps 1) (max max-reach (+ i (list-ref nums i))))])))