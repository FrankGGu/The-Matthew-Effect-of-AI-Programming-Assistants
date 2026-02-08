#lang racket

(define-struct: ListNode ([val : Any] [next : (U ListNode #f)]))

(define/contract (sort-list head)
  ((U ListNode #f) -> (U ListNode #f))
  (if (or (not head) (not (ListNode-next head)))
      head
      (let* ([mid (get-middle head)]
             [right (ListNode-next mid)]
             [ListNode-next mid] = #f)
        (merge (sort-list head) (sort-list right)))))

(define/contract (get-middle head)
  (ListNode -> ListNode)
  (let loop ([slow head] [fast head])
    (if (and fast (ListNode-next fast))
        (loop (ListNode-next slow) (ListNode-next (ListNode-next fast)))
        slow)))

(define/contract (merge left right)
  ((U ListNode #f) (U ListNode #f) -> (U ListNode #f))
  (let ([dummy (make-ListNode 0 #f)])
    (let loop ([current dummy] [left left] [right right])
      (cond [(not left) (ListNode-next current) := right]
            [(not right) (ListNode-next current) := left]
            [(<= (ListNode-val left) (ListNode-val right))
             (ListNode-next current) := left
             (loop (ListNode-next current) (ListNode-next left) right)]
            [else
             (ListNode-next current) := right
             (loop (ListNode-next current) left (ListNode-next right))]))
    (ListNode-next dummy)))