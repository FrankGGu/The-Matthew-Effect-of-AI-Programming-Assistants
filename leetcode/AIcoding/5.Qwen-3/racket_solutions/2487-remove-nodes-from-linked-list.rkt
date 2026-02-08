(define/contract (remove-nodes head)
  (-> (or/c ListNode? #f) (or/c ListNode? #f))
  (let loop ([prev #f] [curr head])
    (cond
      [(not curr) #f]
      [(and prev (= (ListNode-val prev) (ListNode-val curr))) (loop prev (ListNode-next curr))]
      [else (ListNode-set-next! curr (loop curr (ListNode-next curr))) curr])))