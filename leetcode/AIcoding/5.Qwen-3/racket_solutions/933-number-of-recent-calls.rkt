(define-struct queue (elements))

(define (new-queue) (make-queue '()))

(define (enqueue q x) (make-queue (append (queue-elements q) (list x))))

(define (dequeue q) (make-queue (cdr (queue-elements q))))

(define (front q) (car (queue-elements q)))

(define (empty? q) (null? (queue-elements q)))

(define (number-of-recent-calls)
  (let ((q (new-queue)))
    (lambda (t)
      (enqueue q t)
      (let loop ((count 0))
        (if (and (not (empty? q)) (< (front q) (- t 3000)))
            (begin
              (dequeue q)
              (loop (+ count 1)))
            count)))))