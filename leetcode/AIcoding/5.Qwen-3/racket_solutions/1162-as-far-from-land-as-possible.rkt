(define/contract (max-distance grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length grid)]
         [m (if (> n 0) (length (car grid)) 0)]
         [queue (make-queue)]
         [distances (build-list n (lambda (_) (build-list m 0)))]
         [directions '((-1 0) (1 0) (0 -1) (0 1))])
    (for ([i (in-range n)])
      (for ([j (in-range m)])
        (when (= (list-ref (list-ref grid i) j) 1)
          (enqueue! queue (cons i j))
          (set! (list-ref (list-ref distances i) j) 0))))
    (let loop ()
      (when (not (queue-empty? queue))
        (let* ([current (dequeue! queue)]
               [i (car current)]
               [j (cdr current)]
               [current-dist (list-ref (list-ref distances i) j)])
          (for ([d directions])
            (let ([ni (+ i (car d))]
                  [nj (+ j (cdr d))])
              (when (and (<= 0 ni (- n 1)) (<= 0 nj (- m 1)))
                (when (= (list-ref (list-ref distances ni) nj) 0)
                  (set! (list-ref (list-ref distances ni) nj) (+ current-dist 1))
                  (enqueue! queue (cons ni nj)))))))
        (loop)))
    (apply max (flatten distances)))
  )