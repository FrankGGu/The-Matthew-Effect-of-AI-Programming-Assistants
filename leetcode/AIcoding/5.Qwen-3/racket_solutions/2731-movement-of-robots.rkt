(define (robot-movement commands)
  (define (move x y dir)
    (cond [(equal? dir 'up) (values x (+ y 1))]
          [(equal? dir 'down) (values x (- y 1))]
          [(equal? dir 'left) (values (- x 1) y)]
          [(equal? dir 'right) (values (+ x 1) y)]))
  (define (turn dir cmd)
    (cond [(equal? cmd 'L) (if (equal? dir 'up) 'left (if (equal? dir 'left) 'down (if (equal? dir 'down) 'right 'up)))]
          [(equal? cmd 'R) (if (equal? dir 'up) 'right (if (equal? dir 'right) 'down (if (equal? dir 'down) 'left 'up)))]
          [else dir]))
  (define (helper x y dir cmds)
    (if (null? cmds)
        (list x y)
        (let* ([cmd (car cmds)]
               [new-dir (turn dir cmd)]
               [new-x-y (move x y new-dir)])
          (helper (car new-x-y) (cadr new-x-y) new-dir (cdr cmds)))))
  (helper 0 0 'up commands))