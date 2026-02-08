#lang racket

(define (count-submatrices-with-all-ones matrix)
  (define rows (length matrix))
  (define cols (if (null? matrix) 0 (length (car matrix))))
  (define result 0)
  (define (count-ones row)
    (let loop ([i 0] [current 0] [total 0])
      (if (= i cols)
          total
          (if (= (list-ref row i) 1)
              (loop (+ i 1) (+ current 1) (+ total current 1))
              (loop (+ i 1) 0 total)))))
  (define (process-row row)
    (let loop ([i 0] [current 0] [total 0])
      (if (= i cols)
          total
          (if (= (list-ref row i) 1)
              (loop (+ i 1) (+ current 1) (+ total current 1))
              (loop (+ i 1) 0 total)))))
  (define (count-ones-in-row row)
    (let loop ([i 0] [current 0] [total 0])
      (if (= i cols)
          total
          (if (= (list-ref row i) 1)
              (loop (+ i 1) (+ current 1) (+ total current 1))
              (loop (+ i 1) 0 total)))))
  (define (count-ones-in-matrix)
    (let loop ([i 0] [total 0])
      (if (= i rows)
          total
          (loop (+ i 1) (+ total (count-ones-in-row (list-ref matrix i)))))))
  (count-ones-in-matrix))