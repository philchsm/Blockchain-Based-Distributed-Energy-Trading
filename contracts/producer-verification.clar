;; Producer Verification Contract
;; This contract validates energy generators in the system

(define-data-var admin principal tx-sender)

;; Map to store verified producers
(define-map verified-producers principal
  {
    name: (string-utf8 100),
    capacity: uint,
    location: (string-utf8 100),
    verified: bool
  }
)

;; Register a new producer
(define-public (register-producer (name (string-utf8 100)) (capacity uint) (location (string-utf8 100)))
  (begin
    (asserts! (not (is-some (map-get? verified-producers tx-sender))) (err u1))
    (ok (map-set verified-producers tx-sender
      {
        name: name,
        capacity: capacity,
        location: location,
        verified: false
      }
    ))
  )
)

;; Verify a producer (admin only)
(define-public (verify-producer (producer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u2))
    (asserts! (is-some (map-get? verified-producers producer)) (err u3))
    (match (map-get? verified-producers producer)
      producer-data (ok (map-set verified-producers producer
        (merge producer-data { verified: true })
      ))
      (err u4)
    )
  )
)

;; Check if a producer is verified
(define-read-only (is-verified-producer (producer principal))
  (match (map-get? verified-producers producer)
    producer-data (get verified producer-data)
    false
  )
)

;; Get producer details
(define-read-only (get-producer-details (producer principal))
  (map-get? verified-producers producer)
)

;; Transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u5))
    (ok (var-set admin new-admin))
  )
)
