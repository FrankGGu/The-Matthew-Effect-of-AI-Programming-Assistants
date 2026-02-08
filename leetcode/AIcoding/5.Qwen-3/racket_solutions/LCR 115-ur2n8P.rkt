(define (can-reconstruct sequence)
  (define (helper seq)
    (cond [(null? seq) #t]
          [(null? (cdr seq)) #t]
          [else
           (and (<= (car seq) (cadr seq))
                (helper (cdr seq)))]))
  (helper sequence))

(define (is-possible seqs)
  (define (count-degree seqs)
    (define (helper seqs degree)
      (cond [(null? seqs) degree]
            [else
             (let ([s (caar seqs)])
               (if (member s (cdr (car seqs)))
                   (helper (cdr seqs) (cons (cons s 0) degree))
                   (helper (cdr seqs) (cons (cons s 0) degree))))]))
    (helper seqs '()))
  (define (build-graph seqs)
    (define (helper seqs graph)
      (cond [(null? seqs) graph]
            [else
             (let ([s (caar seqs)]
                   [t (cadar seqs)])
               (if (equal? s t)
                   (helper (cdr seqs) graph)
                   (helper (cdr seqs) (cons (cons s (cons t (cdr (assoc s graph)))) graph))))]))
    (helper seqs '()))
  (define (topo-sort graph)
    (define (helper queue visited result)
      (if (null? queue)
          (if (null? visited) result #f)
          (let* ([node (car queue)]
                 [neighbors (cdr (assoc node graph))]
                 [new-queue (append (filter (lambda (x) (not (member x visited))) neighbors) (cdr queue))]
                 [new-visited (cons node visited)]
                 [new-result (cons node result)])
            (helper new-queue new-visited new-result))))
    (let ([in-degree (map (lambda (x) (cons (car x) (length (cdr x)))) graph)])
      (let ([queue (filter (lambda (x) (= (cdr x) 0)) in-degree)])
        (helper (map car queue) '() '()))))
  (let ([graph (build-graph seqs)])
    (let ([topo (topo-sort graph)])
      (and topo (equal? topo (sort (remove-duplicates (apply append seqs)) <)))))

(define (sequence-reconstruction org seqs)
  (if (null? seqs)
      (equal? org '())
      (and (can-reconstruct org)
           (is-possible seqs))))