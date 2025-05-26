;; Transportation Verification Contract
;; Validates mobility services and transportation methods

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INVALID_SERVICE (err u101))
(define-constant ERR_ALREADY_VERIFIED (err u102))

;; Data structures
(define-map verified-services
  { service-id: uint }
  {
    service-type: (string-ascii 50),
    provider: principal,
    is-sustainable: bool,
    verification-date: uint,
    status: (string-ascii 20)
  }
)

(define-map service-providers
  { provider: principal }
  {
    name: (string-ascii 100),
    verified: bool,
    registration-date: uint
  }
)

(define-data-var next-service-id uint u1)

;; Register a new service provider
(define-public (register-provider (name (string-ascii 100)))
  (begin
    (map-set service-providers
      { provider: tx-sender }
      {
        name: name,
        verified: true,
        registration-date: block-height
      }
    )
    (ok true)
  )
)

;; Verify a transportation service
(define-public (verify-service
  (service-type (string-ascii 50))
  (is-sustainable bool))
  (let ((service-id (var-get next-service-id)))
    (begin
      (asserts! (is-some (map-get? service-providers { provider: tx-sender })) ERR_UNAUTHORIZED)
      (map-set verified-services
        { service-id: service-id }
        {
          service-type: service-type,
          provider: tx-sender,
          is-sustainable: is-sustainable,
          verification-date: block-height,
          status: "active"
        }
      )
      (var-set next-service-id (+ service-id u1))
      (ok service-id)
    )
  )
)

;; Get service details
(define-read-only (get-service (service-id uint))
  (map-get? verified-services { service-id: service-id })
)

;; Check if provider is verified
(define-read-only (is-verified-provider (provider principal))
  (match (map-get? service-providers { provider: provider })
    provider-data (get verified provider-data)
    false
  )
)

;; Get next service ID
(define-read-only (get-next-service-id)
  (var-get next-service-id)
)
