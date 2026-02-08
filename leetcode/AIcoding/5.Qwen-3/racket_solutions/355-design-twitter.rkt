#lang racket

(define-struct user (id tweets followers))
(define-struct tweet (user-id timestamp text))

(define (make-twitter)
  (let ((users (hash)))
    (lambda (op . args)
      (cond
        [(equal? op 'post)
         (let ([user-id (car args)]
               [text (cadr args)])
           (when (not (hash-has-key? users user-id))
             (hash-set! users user-id (make-user user-id '() '())))
           (let ([tweets (user-tweets (hash-ref users user-id))])
             (hash-set! users user-id (make-user user-id (cons (make-tweet user-id (current-seconds) text) tweets) (user-followers (hash-ref users user-id))))))]
        [(equal? op 'get-friends-tweets)
         (let ([user-id (car args)]
               [n (cadr args)])
           (define user (hash-ref users user-id #f))
           (if (not user) '()
               (let loop ([friends (user-followers user)] [result '()])
                 (if (null? friends) result
                     (loop (cdr friends)
                           (append (user-tweets (hash-ref users (car friends))) result))))))
        [(equal? op 'follow)
         (let ([follower-id (car args)]
               [followee-id (cadr args)])
           (when (not (hash-has-key? users follower-id))
             (hash-set! users follower-id (make-user follower-id '() '())))
           (when (not (hash-has-key? users followee-id))
             (hash-set! users followee-id (make-user followee-id '() '())))
           (hash-set! users follower-id (make-user follower-id (user-tweets (hash-ref users follower-id)) (cons followee-id (user-followers (hash-ref users follower-id))))))]
        [(equal? op 'unfollow)
         (let ([follower-id (car args)]
               [followee-id (cadr args)])
           (when (hash-has-key? users follower-id)
             (hash-set! users follower-id (make-user follower-id (user-tweets (hash-ref users follower-id)) (remove followee-id (user-followers (hash-ref users follower-id))))))]))))

(define twitter (make-twitter))

(define (post user-id text)
  (twitter 'post user-id text))

(define (get-friends-tweets user-id n)
  (twitter 'get-friends-tweets user-id n))

(define (follow follower-id followee-id)
  (twitter 'follow follower-id followee-id))

(define (unfollow follower-id followee-id)
  (twitter 'unfollow follower-id followee-id))