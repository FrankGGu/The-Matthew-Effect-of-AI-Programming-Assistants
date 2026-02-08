(define (excel-cells-in-range s)
  (let* ([start (substring s 0 1)]
         [end (substring s 1)]
         [start-col (char->integer (string-ref start 0))]
         [end-col (char->integer (string-ref end 0))]
         [start-row (string->number (substring s 1))]
         [end-row (string->number (substring s 2))])
    (for/fold ([result '()])
              ([col (in-range start-col (add1 end-col))])
      (append result
              (for/list ([row (in-range start-row (add1 end-row))])
                (string-append (string (integer->char col)) (number->string row)))))))