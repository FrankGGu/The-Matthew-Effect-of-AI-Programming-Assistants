(define (merge-similar-items items)
  (define (helper acc item)
    (let ([key (car item)]
          [value (cadr item)])
      (if (assoc key acc)
          (let ([existing (assoc key acc)])
            (cons (list key (+ (cadr existing) (cadr item))) (remove existing acc)))
          (cons (list key value) acc))))
  (foldl helper '() items))