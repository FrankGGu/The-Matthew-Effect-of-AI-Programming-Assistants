(define (count-sorted-vowel-strings n)
  (define vowels '(#\a #\e #\i #\j #\o #\u))
  (define (helper i count)
    (if (= i 5)
        count
        (let ((next-count (+ count (if (= i 0) 1 (helper (+ i 1) 0)))))
          (helper (+ i 1) next-count))))
  (helper 0 0))