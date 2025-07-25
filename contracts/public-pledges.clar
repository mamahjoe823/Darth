;; public-pledges.clar
;; A contract for making and recording public good pledges.
;; This contract provides a simple, immutable public ledger where individuals
;; or organizations can make public pledges to perform a certain "public good" action.

;; ---
;; Data Storage
;; ---

;; Counter for total pledges to use as a unique ID.
(define-data-var pledge-id-counter uint u0)

;; Map to store pledges.
;; The key is the pledge ID (uint).
;; The value is a tuple containing the pledger's principal, the pledge text,
;; and the block-height at which the pledge was made.
(define-map pledges uint
  {
    pledger: principal,
    text: (string-utf8 256),
    block-height: uint
  }
)

;; ---
;; Errors
;; ---
(define-constant ERR-EMPTY-PLEDGE (err u100))

;; ---
;; Public Functions
;; ---

;; @desc Makes a public pledge, storing it on the blockchain.
;; @param text: The content of the pledge (max 256 characters).
;; @returns (ok uint) with the new pledge ID, or an error if the text is empty.
(define-public (make-pledge (text (string-utf8 256)))
  (begin
    (asserts! (> (len text) u0) ERR-EMPTY-PLEDGE)
    (let ((new-pledge-id (+ (var-get pledge-id-counter) u1)))
      (map-set pledges new-pledge-id { pledger: tx-sender, text: text, block-height: block-height })
      (var-set pledge-id-counter new-pledge-id)
      (ok new-pledge-id))))

;; ---
;; Read-Only Functions
;; ---

;; @desc Gets a pledge by its ID.
;; @returns (optional {pledger: principal, text: string-utf8, block-height: uint})
(define-read-only (get-pledge (id uint))
  (map-get? pledges id))

;; @desc Gets the total number of pledges made.
;; @returns The current count of pledges as a uint.
(define-read-only (get-pledge-count)
  (var-get pledge-id-counter))