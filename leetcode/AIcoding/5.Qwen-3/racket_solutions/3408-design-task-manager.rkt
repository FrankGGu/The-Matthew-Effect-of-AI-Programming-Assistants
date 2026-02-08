#lang racket

(define-struct task (id priority time))
(define-struct task-manager (tasks))

(define (make-task-manager)
  (make-task-manager '()))

(define (add-task tm id priority time)
  (define new-task (make-task id priority time))
  (define sorted-tasks (sort (task-manager-tasks tm) (lambda (a b) (or (< (task-priority a) (task-priority b)) (and (= (task-priority a) (task-priority b)) (< (task-time a) (task-time b)))))))
  (make-task-manager (cons new-task sorted-tasks)))

(define (get-next-task tm)
  (if (null? (task-manager-tasks tm))
      #f
      (let* ([sorted-tasks (task-manager-tasks tm)]
             [next-task (car sorted-tasks)])
        (make-task-manager (cdr sorted-tasks))
        next-task)))

(define (has-next-task tm)
  (not (null? (task-manager-tasks tm))))