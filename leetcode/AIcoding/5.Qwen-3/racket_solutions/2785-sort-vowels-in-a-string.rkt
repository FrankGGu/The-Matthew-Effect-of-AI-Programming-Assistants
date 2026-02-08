(define (sort-vowels s)
  (define vowels #(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define (is-vowel c)
    (member c vowels))
  (define (char->int c)
    (if (char-upper-case? c)
        (- (char->integer c) (char->integer #\A))
        (- (char->integer c) (char->integer #\a))))
  (define (int->char i)
    (if (>= i 26)
        (integer->char (+ i (char->integer #\A)))
        (integer->char (+ i (char->integer #\a)))))
  (let* ([chars (string->list s)]
         [vowels-list (filter is-vowel chars)]
         [sorted-vowels (sort vowels-list (lambda (a b) (< (char->int a) (char->int b))))]
         [result (map (lambda (c) (if (is-vowel c) (car sorted-vowels) c)) chars)])
    (list->string result)))