(define (make-movie-rental-system)
  (let ([inventory (hash)]
        [rentals (hash)]
        [customers (hash)])
    (define (add-movie movie-id price)
      (hash-set! inventory movie-id price))

    (define (rent movie-id customer-id)
      (if (and (hash-has-key? inventory movie-id)
               (not (hash-has-key? rentals (cons movie-id customer-id))))
          (begin
            (hash-set! rentals (cons movie-id customer-id) #t)
            (hash-set! customers customer-id (cons movie-id (hash-ref customers customer-id '())))
            #t)
          #f))

    (define (return-movie movie-id customer-id)
      (if (hash-has-key? rentals (cons movie-id customer-id))
          (begin
            (hash-remove! rentals (cons movie-id customer-id))
            (hash-set! customers customer-id (remove movie-id (hash-ref customers customer-id)))
            #t)
          #f))

    (define (get-rented-movies customer-id)
      (hash-ref customers customer-id '()))

    (define (get-price movie-id)
      (hash-ref inventory movie-id #f))

    (define (dispatch m . args)
      (cond [(eq? m 'add-movie) (apply add-movie args)]
            [(eq? m 'rent) (apply rent args)]
            [(eq? m 'return) (apply return-movie args)]
            [(eq? m 'get-rented-movies) (apply get-rented-movies args)]
            [(eq? m 'get-price) (apply get-price args)]
            [else (error "Unknown operation")]))

    dispatch))