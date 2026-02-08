#lang racket

(define (contain-virus grid)
  (define (neighbors i j)
    (filter (lambda (p) (and (<= 0 (car p) (- (length grid) 1)) (<= 0 (cadr p) (- (length (list-ref grid 0)) 1))))
            (list (cons (- i 1) j) (cons (+ i 1) j) (cons i (- j 1)) (cons i (+ j 1)))))

  (define (bfs start i j visited)
    (let loop ([queue (list (cons i j))] [visited visited] [area '()] [threat 0])
      (if (null? queue)
          (values area threat visited)
          (let* ([current (car queue)]
                 [i (car current)]
                 [j (cadr current)]
                 [new-queue (append (cdr queue) (filter (lambda (p) (not (member p visited))) (neighbors i j)))]
                 [new-visited (cons current visited)]
                 [new-area (cons current area)])
            (loop new-queue new-visited new-area (if (equal? (list-ref (list-ref grid i) j) 1) (+ threat 1) threat))))))

  (define (mark-visited visited i j)
    (cond [(null? visited) #f]
          [(equal? (car visited) (cons i j)) #t]
          [else (mark-visited (cdr visited) i j)]))

  (define (solve grid)
    (define (loop grid count)
      (let ([max-threat '()]
            [max-area '()]
            [max-visited '()])
        (for-each
         (lambda (i)
           (for-each
            (lambda (j)
              (when (and (= (list-ref (list-ref grid i) j) 1) (not (mark-visited max-visited i j)))
                (let-values ([(area threat visited) (bfs (cons i j) i j '())])
                  (when (> threat (if (null? max-threat) -1 (car max-threat)))
                    (set! max-threat (list threat))
                    (set! max-area area)
                    (set! max-visited visited))))))
         (range (length grid)))
        (if (null? max-threat)
            count
            (begin
              (for-each (lambda (p)
                          (let ([i (car p)] [j (cadr p)])
                            (set! grid (list-set grid i (list-set (list-ref grid i) j 0))))
                        max-area)
              (loop grid (+ count 1))))))
    (loop grid 0))

  (solve (map (lambda (row) (map (lambda (x) x) row)) grid))