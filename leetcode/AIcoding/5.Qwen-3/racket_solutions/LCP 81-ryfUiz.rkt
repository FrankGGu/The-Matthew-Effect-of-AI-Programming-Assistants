(define (make-nand)
  (lambda (a b)
    (if (and a b) #f #t)))

(define (nand->and nand)
  (lambda (a b)
    (nand (nand a b) (nand a b))))

(define (nand->or nand)
  (lambda (a b)
    (nand (nand a a) (nand b b))))

(define (nand->not nand)
  (lambda (a)
    (nand a a)))

(define (nand->xor nand)
  (lambda (a b)
    (let ((nand-a-b (nand a b))
          (nand-a-a (nand a a))
          (nand-b-b (nand b b)))
      (nand (nand nand-a-b nand-a-b) (nand nand-a-a nand-b-b)))))

(define (nand->implies nand)
  (lambda (a b)
    (nand a (nand b b))))