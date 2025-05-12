;; Consumer Verification Contract
;; This contract validates energy users in the system

(define-data-var admin principal tx-sender)

;; Map to store verified consumers
(define-map verified-consumers principal
  {
    name: (string-utf8 100),
    max-consumption: uint,
    location: (string-utf8 100),
    verified: bool
  }
)

;; Register a new consumer
(define-public (register-consumer (name (string-utf8 100)) (max-consumption uint) (location (string-utf8 100)))
  (begin
    (asserts! (not (is-some (map-get? verified-consumers tx-sender))) (err u1))
    (ok (map-set verified-consumers tx-sender
      {
        name: name,
        max-consumption: max-consumption,
        location: location,
        verified: false
      }
    ))
  )
)

;; Verify a consumer (admin only)
(define-public (verify-consumer (consumer principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u2))
    (asserts! (is-some (map-get? verified-consumers consumer)) (err u3))
    (match (map-get? verified-consumers consumer)
      consumer-data (ok (map-set verified-consumers consumer
        (merge consumer-data { verified: true })
      ))
      (err u4)
    )
  )
)

;; Check if a consumer is verified
(define-read-only (is-verified-consumer (consumer principal))
  (match (map-get? verified-consumers consumer)
    consumer-data (get verified consumer-data)
    false
  )
)

;; Get consumer details
(define-read-only (get-consumer-details (consumer principal))
  (map-get? verified-consumers consumer)
)

;; Transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u5))
    (ok (var-set admin new-admin))
  )
)
