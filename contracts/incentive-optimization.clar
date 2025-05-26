;; Incentive Optimization Contract
;; Adjusts reward structures based on usage patterns

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_INVALID_MULTIPLIER (err u501))

;; Data structures
(define-map incentive-multipliers
  { service-type: (string-ascii 50) }
  {
    base-multiplier: uint,
    peak-hour-multiplier: uint,
    weekend-multiplier: uint,
    sustainability-multiplier: uint,
    last-updated: uint
  }
)

(define-map seasonal-adjustments
  { season: (string-ascii 20) }
  {
    adjustment-factor: uint,
    start-block: uint,
    end-block: uint,
    is-active: bool
  }
)

(define-map usage-thresholds
  { threshold-type: (string-ascii 30) }
  {
    daily-threshold: uint,
    weekly-threshold: uint,
    monthly-threshold: uint,
    bonus-multiplier: uint
  }
)

(define-data-var optimization-enabled bool true)
(define-data-var last-optimization-block uint u0)

;; Initialize incentive multipliers
(define-private (init-multipliers)
  (begin
    (map-set incentive-multipliers { service-type: "bike-share" }
      { base-multiplier: u100, peak-hour-multiplier: u150, weekend-multiplier: u120, sustainability-multiplier: u200, last-updated: block-height })
    (map-set incentive-multipliers { service-type: "electric-scooter" }
      { base-multiplier: u100, peak-hour-multiplier: u130, weekend-multiplier: u110, sustainability-multiplier: u180, last-updated: block-height })
    (map-set incentive-multipliers { service-type: "public-transit" }
      { base-multiplier: u100, peak-hour-multiplier: u140, weekend-multiplier: u90, sustainability-multiplier: u250, last-updated: block-height })
    (map-set incentive-multipliers { service-type: "walking" }
      { base-multiplier: u100, peak-hour-multiplier: u110, weekend-multiplier: u130, sustainability-multiplier: u300, last-updated: block-height })
    (map-set incentive-multipliers { service-type: "electric-vehicle" }
      { base-multiplier: u100, peak-hour-multiplier: u120, weekend-multiplier: u100, sustainability-multiplier: u160, last-updated: block-height })
  )
)

;; Initialize usage thresholds
(define-private (init-thresholds)
  (begin
    (map-set usage-thresholds { threshold-type: "frequent-user" }
      { daily-threshold: u5, weekly-threshold: u20, monthly-threshold: u80, bonus-multiplier: u150 })
    (map-set usage-thresholds { threshold-type: "eco-warrior" }
      { daily-threshold: u3, weekly-threshold: u15, monthly-threshold: u60, bonus-multiplier: u200 })
    (map-set usage-thresholds { threshold-type: "weekend-explorer" }
      { daily-threshold: u2, weekly-threshold: u8, monthly-threshold: u30, bonus-multiplier: u130 })
  )
)

;; Calculate optimized credits
(define-public (calculate-optimized-credits
  (base-credits uint)
  (service-type (string-ascii 50))
  (is-peak-hour bool)
  (is-weekend bool)
  (is-sustainable bool))
  (let (
    (multipliers (unwrap! (map-get? incentive-multipliers { service-type: service-type }) (err u0)))
    (base-multiplier (get base-multiplier multipliers))
    (peak-multiplier (if is-peak-hour (get peak-hour-multiplier multipliers) u100))
    (weekend-multiplier (if is-weekend (get weekend-multiplier multipliers) u100))
    (sustainability-multiplier (if is-sustainable (get sustainability-multiplier multipliers) u100))
    (total-multiplier (/ (* (* (* base-multiplier peak-multiplier) weekend-multiplier) sustainability-multiplier) u1000000))
  )
    (ok (/ (* base-credits total-multiplier) u100))
  )
)

;; Update incentive multipliers (admin only)
(define-public (update-multipliers
  (service-type (string-ascii 50))
  (base-multiplier uint)
  (peak-hour-multiplier uint)
  (weekend-multiplier uint)
  (sustainability-multiplier uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (and (>= base-multiplier u50) (<= base-multiplier u300)) ERR_INVALID_MULTIPLIER)
    (map-set incentive-multipliers
      { service-type: service-type }
      {
        base-multiplier: base-multiplier,
        peak-hour-multiplier: peak-hour-multiplier,
        weekend-multiplier: weekend-multiplier,
        sustainability-multiplier: sustainability-multiplier,
        last-updated: block-height
      }
    )
    (ok true)
  )
)

;; Set seasonal adjustment
(define-public (set-seasonal-adjustment
  (season (string-ascii 20))
  (adjustment-factor uint)
  (start-block uint)
  (end-block uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (map-set seasonal-adjustments
      { season: season }
      {
        adjustment-factor: adjustment-factor,
        start-block: start-block,
        end-block: end-block,
        is-active: true
      }
    )
    (ok true)
  )
)

;; Get current multipliers for service type
(define-read-only (get-multipliers (service-type (string-ascii 50)))
  (map-get? incentive-multipliers { service-type: service-type })
)

;; Get seasonal adjustment
(define-read-only (get-seasonal-adjustment (season (string-ascii 20)))
  (map-get? seasonal-adjustments { season: season })
)

;; Get usage threshold
(define-read-only (get-usage-threshold (threshold-type (string-ascii 30)))
  (map-get? usage-thresholds { threshold-type: threshold-type })
)

;; Check if optimization is enabled
(define-read-only (is-optimization-enabled)
  (var-get optimization-enabled)
)

;; Toggle optimization (admin only)
(define-public (toggle-optimization)
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (var-set optimization-enabled (not (var-get optimization-enabled)))
    (ok (var-get optimization-enabled))
  )
)

;; Initialize the contract
(begin
  (init-multipliers)
  (init-thresholds)
)
