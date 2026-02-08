(define (find-difference nums1 nums2)
  (define set1 (list->set nums1))
  (define set2 (list->set nums2))
  (list
   (set->list (set-subtract set1 set2))
   (set->list (set-subtract set2 set1))))