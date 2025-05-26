;; Credit Issuance Contract
;; Creates and manages mobility reward units

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_INSUFFICIENT_BALANCE (err u201))
(define-constant ERR_INVALID_AMOUNT (err u202))

;; Token definition
(define-fungible-token mobility-credits)

;; Data structures
(define-map user-balances
  { user: principal }
  {
    total-earned: uint,
    total-spent: uint,
    last-activity: uint
  }
)

(define-map credit-rates
  { service-type: (string-ascii 50) }
  {
    base-rate: uint,
    sustainability-bonus: uint,
    last-updated: uint
  }
)

(define-data-var total-credits-issued uint u0)

;; Initialize credit rates
(define-private (init-credit-rates)
  (begin
    (map-set credit-rates { service-type: "bike-share" } { base-rate: u10, sustainability-bonus: u5, last-updated: block-height })
    (map-set credit-rates { service-type: "electric-scooter" } { base-rate: u8, sustainability-bonus: u4, last-updated: block-height })
    (map-set credit-rates { service-type: "public-transit" } { base-rate: u15, sustainability-bonus: u10, last-updated: block-height })
    (map-set credit-rates { service-type: "walking" } { base-rate: u5, sustainability-bonus: u8, last-updated: block-height })
    (map-set credit-rates { service-type: "electric-vehicle" } { base-rate: u12, sustainability-bonus: u6, last-updated: block-height })
  )
)

;; Issue credits to user
(define-public (issue-credits
  (recipient principal)
  (service-type (string-ascii 50))
  (is-sustainable bool)
  (distance uint))
  (let (
    (rate-data (unwrap! (map-get? credit-rates { service-type: service-type }) ERR_INVALID_AMOUNT))
    (base-credits (* (get base-rate rate-data) distance))
    (bonus-credits (if is-sustainable (* (get sustainability-bonus rate-data) distance) u0))
    (total-credits (+ base-credits bonus-credits))
  )
    (begin
      (try! (ft-mint? mobility-credits total-credits recipient))
      (map-set user-balances
        { user: recipient }
        (merge
          (default-to { total-earned: u0, total-spent: u0, last-activity: u0 }
                     (map-get? user-balances { user: recipient }))
          {
            total-earned: (+ (default-to u0 (get total-earned (map-get? user-balances { user: recipient }))) total-credits),
            last-activity: block-height
          }
        )
      )
      (var-set total-credits-issued (+ (var-get total-credits-issued) total-credits))
      (ok total-credits)
    )
  )
)

;; Update credit rates (admin only)
(define-public (update-credit-rate
  (service-type (string-ascii 50))
  (base-rate uint)
  (sustainability-bonus uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (map-set credit-rates
      { service-type: service-type }
      {
        base-rate: base-rate,
        sustainability-bonus: sustainability-bonus,
        last-updated: block-height
      }
    )
    (ok true)
  )
)

;; Get user balance
(define-read-only (get-balance (user principal))
  (ft-get-balance mobility-credits user)
)

;; Get credit rate for service type
(define-read-only (get-credit-rate (service-type (string-ascii 50)))
  (map-get? credit-rates { service-type: service-type })
)

;; Get user statistics
(define-read-only (get-user-stats (user principal))
  (map-get? user-balances { user: user })
)

;; Get total credits issued
(define-read-only (get-total-credits-issued)
  (var-get total-credits-issued)
)

;; Initialize the contract
(begin (init-credit-rates))
