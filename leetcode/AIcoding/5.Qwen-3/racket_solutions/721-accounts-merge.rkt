#lang racket

(define (accounts-merge accounts)
  (define (find parent x)
    (if (equal? (vector-ref parent x) x)
        x
        (let ([root (find parent (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union parent x y)
    (let ([root-x (find parent x)]
          [root-y (find parent y)])
      (when (not (equal? root-x root-y))
        (vector-set! parent root-y root-x))))

  (define (merge-accounts accounts)
    (define n (length accounts))
    (define parent (make-vector n 0))
    (for ([i (in-range n)])
      (vector-set! parent i i))

    (define email-to-index (make-hash))
    (for ([i (in-range n)]
          [account accounts])
      (for ([email (cdr account)])
        (hash-set! email-to-index email i)))

    (for ([i (in-range n)])
      (for ([email (cdr accounts[i])])
        (when (hash-has-key? email-to-index email)
          (union parent i (hash-ref email-to-index email)))))

    (define index-to-emails (make-hash))
    (for ([i (in-range n)])
      (define root (find parent i))
      (define emails (append (list (car accounts[i])) (cdr accounts[i])))
      (hash-update! index-to-emails root (lambda (lst) (append lst emails)) '()))

    (define result '())
    (for ([(key value) (hash->list index-to-emails)])
      (set! result (cons (cons (car (car accounts)) (sort (remove-duplicates value string<?)) ) result)))
    result)

  (merge-accounts accounts))