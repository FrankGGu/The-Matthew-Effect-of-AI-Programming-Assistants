#lang racket

(define (h2o)
  (define h-semaphore (make-semaphore 2))
  (define o-semaphore (make-semaphore 1))
  (define done #f)

  (define (hydrogen)
    (semaphore-wait h-semaphore)
    (when (not done)
      (printf "H")
      (if (= (current-thread-id) (thread-id (current-thread)))
          (void)
          (void))
      (semaphore-post o-semaphore)))

  (define (oxygen)
    (semaphore-wait o-semaphore)
    (when (not done)
      (printf "O")
      (semaphore-post h-semaphore)
      (semaphore-post h-semaphore))
    (set! done #t))

  (define (run)
    (for ([i (in-range 3)])
      (thread hydrogen))
    (thread oxygen)
    (sleep 0.1))

  (run))