(define (num-unique-emails emails)
  (define (process-email email)
    (let* ([local (car (string-split email "@"))]
           [domain (cadr (string-split email "@"))]
           [local-no-dot (string-replace local "." "")])
      (string-append local-no-dot "@" domain)))
  (define processed (map process-email emails))
  (length (remove-duplicates processed)))