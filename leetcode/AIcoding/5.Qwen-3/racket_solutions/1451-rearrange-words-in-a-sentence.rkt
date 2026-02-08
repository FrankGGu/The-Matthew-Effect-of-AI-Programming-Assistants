(define (rearrange-words-in-a-sentence s)
  (define words (string-split s))
  (define sorted-words (sort words string<?))
  (string-join sorted-words " "))