(define-struct rand-table (nums map))

(define (make-randomized-set)
  (make-rand-table '() (hash)))

(define (insert rand-set val)
  (let ((map (rand-table-map rand-set)))
    (if (hash-has-key? map val)
        #f
        (begin
          (set! (rand-table-map rand-set) (hash-set map val (length (rand-table-nums rand-set))))
          (set! (rand-table-nums rand-set) (append (rand-table-nums rand-set) (list val)))
          #t)))

(define (delete rand-set val)
  (let ((map (rand-table-map rand-set))
        (nums (rand-table-nums rand-set)))
    (if (not (hash-has-key? map val))
        #f
        (begin
          (let* ((index (hash-ref map val))
                 (last-val (last nums))
                 (last-index (sub1 (length nums))))
            (set! (rand-table-nums rand-set) (append (take nums index) (list last-val) (take-right nums (- (length nums) index 1))))
            (set! (rand-table-map rand-set) (hash-set (hash-remove map val) last-val index))
            (when (not (= index last-index))
              (set! (rand-table-map rand-set) (hash-set (rand-table-map rand-set) last-val index)))
          #t))))

(define (get-random rand-set)
  (let ((nums (rand-table-nums rand-set)))
    (list-ref nums (random (length nums))))