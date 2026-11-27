# Generated client for the Reservepay Merchant API webfunction package.
# Source: https://api.reservepay.com/merchants
#
# Wraps the real web_function gem (github.com/robinclart/web_function) -
# every method here calls straight through to the real dynamic client.
# frozen_string_literal: true

require "web_function"

module Reservepay
  module Merchant
    # Wraps a real WebFunction::Page, mapping each item on the page through
    # item_class (or leaving it untouched if item_class is nil, for a
    # bare scalar-item pagination). Recurses through next_page/previous_page
    # so pagination stays typed across every page, not just the first.
    #
    # The real gem only wraps a response in Page when it strictly matches
    # its own pagination-envelope shape (confirmed from the real
    # page.rb/request.rb source: a Hash with "page"/"next"/"previous" keys
    # present, "page" an Array, "next"/"previous" each nil or a Hash) -
    # otherwise Request#execute returns the raw decoded value completely
    # unwrapped. A real API can plausibly fail that check for an edge case
    # the real gem's author didn't anticipate (e.g. a zero-result response
    # that omits the "next"/"previous" keys entirely rather than nulling
    # them) - every method here checks respond_to? first and degrades to a
    # single, final page of whatever raw data is actually present, rather
    # than raising deep inside here when that happens.
    class TypedPage
      include Enumerable

      def initialize(real_page, item_class)
        @real_page = real_page
        @item_class = item_class
      end

      def page
        unless @real_page.respond_to?(:page)
          raw_items = @real_page.is_a?(Hash) ? (@real_page["page"] || []) : Array(@real_page)
          return @item_class ? raw_items.map { |item| @item_class.new(item) } : raw_items
        end

        @item_class ? @real_page.page.map { |item| @item_class.new(item) } : @real_page.page
      end

      def next?
        @real_page.respond_to?(:next?) ? @real_page.next? : false
      end

      def previous?
        @real_page.respond_to?(:previous?) ? @real_page.previous? : false
      end

      def next_page
        return nil unless @real_page.respond_to?(:next_page)

        next_real = @real_page.next_page
        next_real && TypedPage.new(next_real, @item_class)
      end

      def previous_page
        return nil unless @real_page.respond_to?(:previous_page)

        previous_real = @real_page.previous_page
        previous_real && TypedPage.new(previous_real, @item_class)
      end

      def each(&block)
        return enum_for(:each) unless block

        page.each(&block)
        self
      end
    end

    class PaymentMethodAttributes
      def initialize(raw)
        @raw = raw
      end

      # The name of the payment method.
      def name
        @raw["name"]
      end

      # The display name of the payment method.
      def display_name
        @raw["display_name"]
      end

      # The flow of the payment method.
      def flow
        @raw["flow"]
      end

      # The category of the payment method.
      def category
        @raw["category"]
      end

      # The platforms on which the payment method is available.
      def platforms
        @raw["platforms"]
      end

    end

    class InstallationAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the installation.
      def installation_id
        @raw["installation_id"]
      end

      # Whether the installation is enabled and active.
      def enabled
        @raw["enabled"]
      end

      # The name of the installation.
      def name
        @raw["name"]
      end

      # The platform type of the installation (e.g., 'WEB', 'IOS', 'ANDROID', 'TERMINAL').
      def platform
        @raw["platform"]
      end

      # The unique identifier for the installation on the platform.
      def identifier
        @raw["identifier"]
      end

      # List of payment methods supported by this installation.
      def payment_methods
        (@raw["payment_methods"] || []).map { |item| PaymentMethodAttributes.new(item) }
      end

      # Email capture configuration for this installation. 'disabled' means no email collection, 'optional' means email is collected if provided by customer, 'required' means email is mandatory for all customers.
      def email_capture
        @raw["email_capture"]
      end

      # Mobile phone capture configuration for this installation. 'disabled' means no mobile number collection, 'optional' means mobile number is collected if provided by customer, 'required' means mobile number is mandatory for all customers.
      def mobile_capture
        @raw["mobile_capture"]
      end

      # Billing address capture configuration for this installation. 'disabled' means no billing address collection, 'optional' means billing address is collected if provided by customer, 'required' means billing address is mandatory for all customers.
      def address_capture
        @raw["address_capture"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

    end

    class AddPaymentLinkResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment link.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the batch that created this payment link, if any.
      def batch_id
        @raw["batch_id"]
      end

      # The URL of the payment link.
      def payment_link_url
        @raw["payment_link_url"]
      end

      # The current status of the payment link.
      def status
        @raw["status"]
      end

      # The amount of the payment link in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The payment-link-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The description of the payment link.
      def description
        @raw["description"]
      end

      # The merchant's internal reference for this link.
      def external_id
        @raw["external_id"]
      end

      # When the link becomes invalid (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # If true, the link expires after one successful payment.
      def single_use
        @raw["single_use"]
      end

      # Whether payments from this link are captured automatically. Installments and other payment methods that do not support authorization are always captured.
      def capture
        @raw["capture"]
      end

      # If true, sends a confirmation email to the customer after each successful payment.
      def send_confirmation_email
        @raw["send_confirmation_email"]
      end

      # The installation associated with this payment link.
      def installation
        (v = @raw["installation"]) && InstallationAttributes.new(v)
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # If true, the payment link has no associated payments and can be removed.
      def deletable
        @raw["deletable"]
      end

    end

    class EntryAttributes
      def initialize(raw)
        @raw = raw
      end

      # Unique identifier of this ledger entry.
      def entry_id
        @raw["entry_id"]
      end

      # Unique identifier of the transaction that contains this entry.
      def transaction_id
        @raw["transaction_id"]
      end

      # Whether this entry is a credit or debit for the balance.
      def direction
        @raw["direction"]
      end

      # Entry name (e.g. ADD_PREFUND, INVOICE, PAY_OUT.
      def type
        @raw["type"]
      end

      # Entry amount in currency subunits (always positive; use direction for sign semantics).
      def amount
        @raw["amount"]
      end

      # ISO currency code.
      def currency
        @raw["currency"]
      end

      # Lifecycle status of the entry at the time of the request.
      def status
        @raw["status"]
      end

      # Invoice ID when this entry's transaction is linked to an invoice.
      def invoice_id
        @raw["invoice_id"]
      end

      # Merchant statement ID when this entry's transaction is linked to a statement.
      def statement_id
        @raw["statement_id"]
      end

      # Payout ID when this entry's transaction is linked to a payout.
      def payout_id
        @raw["payout_id"]
      end

      # Topup ID when this entry's transaction is linked to a topup.
      def topup_id
        @raw["topup_id"]
      end

      # Dispute ID when this entry's transaction is linked to a dispute.
      def dispute_id
        @raw["dispute_id"]
      end

      # Payment ID when this entry's transaction is linked to a dispute.
      def parent_id
        @raw["parent_id"]
      end

      # Parent object type when this entry's transaction is linked to a dispute.
      def parent_type
        @raw["parent_type"]
      end

      # Unix timestamp when the entry was created.
      def created_at
        @raw["created_at"]
      end

      # Unix timestamp when the entry became effective for the ledger, if applicable.
      def effective_at
        @raw["effective_at"]
      end

      # Unix timestamp when the entry was canceled, if applicable.
      def canceled_at
        @raw["canceled_at"]
      end

    end

    class ClonePaymentLinkResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment link.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the batch that created this payment link, if any.
      def batch_id
        @raw["batch_id"]
      end

      # The URL of the payment link.
      def payment_link_url
        @raw["payment_link_url"]
      end

      # The current status of the payment link.
      def status
        @raw["status"]
      end

      # The amount of the payment link in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The payment-link-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The description of the payment link.
      def description
        @raw["description"]
      end

      # The merchant's internal reference for this link.
      def external_id
        @raw["external_id"]
      end

      # When the link becomes invalid (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # If true, the link expires after one successful payment.
      def single_use
        @raw["single_use"]
      end

      # Whether payments from this link are captured automatically. Installments and other payment methods that do not support authorization are always captured.
      def capture
        @raw["capture"]
      end

      # If true, sends a confirmation email to the customer after each successful payment.
      def send_confirmation_email
        @raw["send_confirmation_email"]
      end

      # The installation associated with this payment link.
      def installation
        (v = @raw["installation"]) && InstallationAttributes.new(v)
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # If true, the payment link has no associated payments and can be removed.
      def deletable
        @raw["deletable"]
      end

    end

    class BankAccountAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the bank account.
      def bank_account_id
        @raw["bank_account_id"]
      end

      # The bank code identifying the financial institution.
      def bank_code
        @raw["bank_code"]
      end

      # The bank account number.
      def number
        @raw["number"]
      end

      # The name of the account holder.
      def name
        @raw["name"]
      end

      # The ISO country code where the bank account is located.
      def country_code
        @raw["country_code"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was deleted.
      def deleted_at
        @raw["deleted_at"]
      end

      # Whether the bank account can be deleted. A bank account is deletable if it is not the primary bank account, or if it is the primary bank account but it is the only bank account for the contact.
      def deletable
        @raw["deletable"]
      end

      # Whether this bank account belongs to a contact or the merchant.
      def owner
        @raw["owner"]
      end

      # Whether this is the primary bank account for its owner (the contact or the merchant).
      def primary
        @raw["primary"]
      end

    end

    class CardAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the card.
      def card_id
        @raw["card_id"]
      end

      # The token of the card.
      def token
        @raw["token"]
      end

      # Whether the card token is for single or multiple use.
      def usage
        @raw["usage"]
      end

      # Whether the card token has been used.
      def used
        @raw["used"]
      end

      # The first 6 digits of the card number.
      def first_digits
        @raw["first_digits"]
      end

      # The last 2 digits of the card number.
      def last_digits
        @raw["last_digits"]
      end

      # The length of the card number.
      def length
        @raw["length"]
      end

      # The expiration date of the card (MM/YY format).
      def expiration_date
        @raw["expiration_date"]
      end

      # The name of the cardholder.
      def cardholder_name
        @raw["cardholder_name"]
      end

      # The card scheme (e.g., VISA, MASTERCARD).
      def scheme
        @raw["scheme"]
      end

      # The Unix timestamp (seconds since epoch) when the card was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the card was deleted.
      def deleted_at
        @raw["deleted_at"]
      end

      # Whether the card can be deleted. A card is deletable if it is not the default card, or if it is the default card but it is the only card for the contact.
      def deletable
        @raw["deletable"]
      end

    end

    class ContactAttributes
      def initialize(raw)
        @raw = raw
      end

      # The internal unique identifier for the contact.
      def contact_id
        @raw["contact_id"]
      end

      # The external ID provided when the contact was created.
      def external_id
        @raw["external_id"]
      end

      # The email address of the contact.
      def email
        @raw["email"]
      end

      # The mobile number of the contact.
      def mobile
        @raw["mobile"]
      end

      # The name of the contact.
      def name
        @raw["name"]
      end

      # Whether the contact is marked as a favorite.
      def favorite
        @raw["favorite"]
      end

      # The Unix timestamp (seconds since epoch) when the contact was created.
      def created_at
        @raw["created_at"]
      end

      # The primary bank account for the contact.
      def primary_bank_account
        (v = @raw["primary_bank_account"]) && BankAccountAttributes.new(v)
      end

      # The default card for the contact.
      def default_card
        (v = @raw["default_card"]) && CardAttributes.new(v)
      end

      # The most recent bank accounts associated with the contact (limited to 25 most recent, ordered by creation date descending).
      def bank_accounts
        (@raw["bank_accounts"] || []).map { |item| BankAccountAttributes.new(item) }
      end

      # The most recent cards associated with the contact (limited to 25 most recent, ordered by creation date descending).
      def cards
        (@raw["cards"] || []).map { |item| CardAttributes.new(item) }
      end

    end

    class PaymentLinkAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment link.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the batch that created this payment link, if any.
      def batch_id
        @raw["batch_id"]
      end

      # The URL of the payment link.
      def payment_link_url
        @raw["payment_link_url"]
      end

      # The current status of the payment link.
      def status
        @raw["status"]
      end

      # The amount of the payment link in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The payment-link-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The description of the payment link.
      def description
        @raw["description"]
      end

      # The merchant's internal reference for this link.
      def external_id
        @raw["external_id"]
      end

      # When the link becomes invalid (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # If true, the link expires after one successful payment.
      def single_use
        @raw["single_use"]
      end

      # Whether payments from this link are captured automatically. Installments and other payment methods that do not support authorization are always captured.
      def capture
        @raw["capture"]
      end

      # If true, sends a confirmation email to the customer after each successful payment.
      def send_confirmation_email
        @raw["send_confirmation_email"]
      end

      # The installation associated with this payment link.
      def installation
        (v = @raw["installation"]) && InstallationAttributes.new(v)
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # If true, the payment link has no associated payments and can be removed.
      def deletable
        @raw["deletable"]
      end

    end

    class FeeAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the fee.
      def fee_id
        @raw["fee_id"]
      end

      # The type of fee.
      def kind
        @raw["kind"]
      end

      # The ID of the billable item that this fee is attached to. For example, if the fee is a dispute fee, this would be the ID of the dispute.
      def parent_id
        @raw["parent_id"]
      end

      # The billing code of the fee.
      def billing_code
        @raw["billing_code"]
      end

      # The unit amount of the fee, in subunits. I.e. how much is billed for each unit of the fee.
      def unit_amount
        @raw["unit_amount"]
      end

      # The percentage amount of the fee, in subunits. E.g. With a percentage_fee of 4%, a payment of 1000 THB would have a percentage_amount of 40_00.
      def percentage_amount
        @raw["percentage_amount"]
      end

      # Whether the fee has been discounted.
      def discount_applied
        @raw["discount_applied"]
      end

      # The ID of the statement that this fee is attached to.
      def statement_id
        @raw["statement_id"]
      end

    end

    class PaymentAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment.
      def payment_id
        @raw["payment_id"]
      end

      # The merchant's internal reference for this payment.
      def external_id
        @raw["external_id"]
      end

      # The current status of the payment.
      def status
        @raw["status"]
      end

      # The payment amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The payment method used (e.g., 'PROMPTPAY', 'CARD').
      def payment_method
        @raw["payment_method"]
      end

      # The category of the payment method.
      def payment_method_category
        @raw["payment_method_category"]
      end

      # The display name of the payment method.
      def payment_method_display_name
        @raw["payment_method_display_name"]
      end

      # The first 6 digits of the card number. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_first_digits
        @raw["card_first_digits"]
      end

      # The last 2 digits of the card number. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_last_digits
        @raw["card_last_digits"]
      end

      # The card number with the first 6 and last 2 digits visible and the rest masked. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_masked_number
        @raw["card_masked_number"]
      end

      # The card network, such as visa or mastercard. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_network
        @raw["card_network"]
      end

      # The cardholder's name as entered on the card. Null for non-card payment methods, card payments without card details, or when no name was entered. Always null for EDC payments, as the partner app only reports the card number digits.
      def cardholder_name
        @raw["cardholder_name"]
      end

      # The card's expiration date as captured, usually in MM/YY format. Null for non-card payment methods, card payments without card details, or when no expiration date was captured. Always null for EDC payments, as the partner app only reports the card number digits.
      def card_expiration_date
        @raw["card_expiration_date"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # When the payment was authorized (Unix timestamp).
      def authorized_at
        @raw["authorized_at"]
      end

      # When the payment was captured (Unix timestamp).
      def captured_at
        @raw["captured_at"]
      end

      # When the payment was voided (Unix timestamp).
      def voided_at
        @raw["voided_at"]
      end

      # When the payment was cancelled (Unix timestamp).
      def cancelled_at
        @raw["cancelled_at"]
      end

      # When the payment becomes eligible for refund (Unix timestamp). Present only while the payment is still within its void window.
      def refundable_at
        @raw["refundable_at"]
      end

      # When the payment expires (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # Whether the capture is automatic or manual.
      def capture
        @raw["capture"]
      end

      # The ID of the customer (contact) associated with this payment.
      def customer_id
        @raw["customer_id"]
      end

      # The merchant's external reference for the customer (contact), if set.
      def customer_external_id
        @raw["customer_external_id"]
      end

      # The email address of the customer.
      def customer_email
        @raw["customer_email"]
      end

      # The mobile phone number of the customer.
      def customer_mobile
        @raw["customer_mobile"]
      end

      # The name of the customer.
      def customer_name
        @raw["customer_name"]
      end

      # The fees associated with the payment.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # The first custom reference (e.g., invoice ID).
      def ref1
        @raw["ref1"]
      end

      # The second custom reference.
      def ref2
        @raw["ref2"]
      end

      # The third custom reference.
      def ref3
        @raw["ref3"]
      end

      # Whether the payment can be reversed.
      def reversible
        @raw["reversible"]
      end

      # Whether the payment can be captured.
      def capturable
        @raw["capturable"]
      end

      # Whether the payment can be voided.
      def voidable
        @raw["voidable"]
      end

      # Whether the payment can be cancelled.
      def cancellable
        @raw["cancellable"]
      end

      # Whether the payment can be refunded.
      def refundable
        @raw["refundable"]
      end

      # Whether the payment is considered risky or safe from a fraud perspective.
      def fraud_finding
        @raw["fraud_finding"]
      end

      # The failure code for a failed payment.
      def failure_code
        @raw["failure_code"]
      end

      # A description of why the payment failed
      def failure_message
        @raw["failure_message"]
      end

      # The ID of the terminal that created the payment, if any.
      def terminal_id
        @raw["terminal_id"]
      end

      # The ID of the payment link that created the payment, if any.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the payment session associated with this payment, if any.
      def payment_session_id
        @raw["payment_session_id"]
      end

      # The ID of the checkout associated with this payment, if any.
      def checkout_id
        @raw["checkout_id"]
      end

      # The number of monthly installments. Null for non-installment payments.
      def installment_term
        @raw["installment_term"]
      end

      # Who bears the installment interest. Null for non-installment payments.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The monthly interest rate of the installment plan as a percentage on a 0-100 scale (e.g. `1.5` means 1.5% per month), snapshotted when the payment method was selected. Not zeroed when the merchant bears the interest; see `interest_bearer`. Null for non-installment payments.
      def installment_interest_rate
        @raw["installment_interest_rate"]
      end

      # The total interest over the full term at the installment plan rate, in the smallest currency unit, snapshotted when the payment method was selected. Present for both interest bearers; `interest_bearer` says who pays it. Null for non-installment payments.
      def installment_interest_amount
        @raw["installment_interest_amount"]
      end

      # The name of the bank providing the installment plan. Null for non-installment payments.
      def installment_bank_name
        @raw["installment_bank_name"]
      end

      # The display name of the bank providing the installment plan. Null for non-installment payments.
      def installment_bank_display_name
        @raw["installment_bank_display_name"]
      end

    end

    class PayoutAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payout.
      def payout_id
        @raw["payout_id"]
      end

      # The external ID of the payout.
      def external_id
        @raw["external_id"]
      end

      # The current status of the payout.
      def status
        @raw["status"]
      end

      # The payout amount in subunits.
      def amount
        @raw["amount"]
      end

      # The currency code of the payout.
      def currency
        @raw["currency"]
      end

      # The timestamp when the payout was created.
      def created_at
        @raw["created_at"]
      end

      # The timestamp when the payout was settled/paid.
      def paid_at
        @raw["paid_at"]
      end

      # The timestamp when the payout was sent.
      def sent_at
        @raw["sent_at"]
      end

      # The ID of the bank account for the payout.
      def bank_account_id
        @raw["bank_account_id"]
      end

      # The bank code identifying the financial institution.
      def bank_code
        @raw["bank_code"]
      end

      # The bank account number.
      def bank_account_number
        @raw["bank_account_number"]
      end

      # The name of the account holder.
      def bank_account_name
        @raw["bank_account_name"]
      end

      # The ISO country code where the bank account is located.
      def bank_country_code
        @raw["bank_country_code"]
      end

      # The payout method name.
      def payout_method
        @raw["payout_method"]
      end

      # The mobile number for PromptPay payouts (when payout_method is mobile_number).
      def mobile_number
        @raw["mobile_number"]
      end

      # The national ID for PromptPay payouts (when payout_method is national_id).
      def national_id
        @raw["national_id"]
      end

      # The fees associated with the payout.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # The first custom reference (e.g., internal payout ID).
      def ref1
        @raw["ref1"]
      end

      # Whether this payout is awaiting secondary authorization before it can be processed.
      def needs_authorization
        @raw["needs_authorization"]
      end

      # The ID of the user who requested the payout (for user session-created payouts only).
      def requested_by_user_id
        @raw["requested_by_user_id"]
      end

      # The email address of the user who requested the payout (for user session-created payouts only).
      def requested_by_user_email
        @raw["requested_by_user_email"]
      end

      # The ID of the user who authorized the payout (applicable to contact payouts that require secondary authorization only).
      def authorized_by_user_id
        @raw["authorized_by_user_id"]
      end

      # The email address of the user who authorized the payout (applicable to contact payouts that require secondary authorization only).
      def authorized_by_user_email
        @raw["authorized_by_user_email"]
      end

      # The ID of the user who rejected the payout (applicable to contact payouts that require secondary authorization only).
      def rejected_by_user_id
        @raw["rejected_by_user_id"]
      end

      # The email address of the user who rejected the payout (applicable to contact payouts that require secondary authorization only).
      def rejected_by_user_email
        @raw["rejected_by_user_email"]
      end

    end

    class TerminalAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the terminal.
      def terminal_id
        @raw["terminal_id"]
      end

      # Whether the terminal currently has an active device connection.
      def connected
        @raw["connected"]
      end

      # External identifier of the terminal (from your system).
      def external_id
        @raw["external_id"]
      end

      # The installation ID associated with this terminal, if any.
      def installation_id
        @raw["installation_id"]
      end

      # Human-readable name of the terminal.
      def name
        @raw["name"]
      end

      # Optional branch/store name this terminal belongs to.
      def branch_name
        @raw["branch_name"]
      end

      # Whether the terminal is enabled.
      def enabled
        @raw["enabled"]
      end

      # Whether the terminal is in kiosk mode.
      def kiosk_mode
        @raw["kiosk_mode"]
      end

      # When the device last verified, as a Unix timestamp. Null if never.
      def last_verified_at
        @raw["last_verified_at"]
      end

      # When the device last connected, as a Unix timestamp. Null if never.
      def connected_at
        @raw["connected_at"]
      end

      # The ID of the child terminal this terminal delegates payment display to, if any.
      def delegated_terminal_id
        @raw["delegated_terminal_id"]
      end

      # The ID of the parent terminal that delegates payment display to this terminal, if any.
      def parent_terminal_id
        @raw["parent_terminal_id"]
      end

      # One-time challenge to embed in the terminal QR code. Rotates after each successful device connection.
      def challenge
        @raw["challenge"]
      end

    end

    class TopupAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the topup.
      def topup_id
        @raw["topup_id"]
      end

      # The current status of the topup.
      def status
        @raw["status"]
      end

      # How the topup was funded. 'MANUAL' for a direct bank transfer, 'VIRTUAL_ACCOUNT' for funds received through a virtual account.
      def type
        @raw["type"]
      end

      # The topup amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The bank transaction reference for the incoming transfer.
      def transaction_id
        @raw["transaction_id"]
      end

      # The name on the sender's bank account.
      def sender_account_name
        @raw["sender_account_name"]
      end

      # The sender's bank account number.
      def sender_account_number
        @raw["sender_account_number"]
      end

      # The sender's 3-digit bank code.
      def sender_bank_code
        @raw["sender_bank_code"]
      end

      # The number of the virtual account that received the funds. Null for manual topups.
      def virtual_account_number
        @raw["virtual_account_number"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class FindBankAccountResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the bank account.
      def bank_account_id
        @raw["bank_account_id"]
      end

      # The bank code identifying the financial institution.
      def bank_code
        @raw["bank_code"]
      end

      # The bank account number.
      def number
        @raw["number"]
      end

      # The name of the account holder.
      def name
        @raw["name"]
      end

      # The ISO country code where the bank account is located.
      def country_code
        @raw["country_code"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was deleted.
      def deleted_at
        @raw["deleted_at"]
      end

      # Whether the bank account can be deleted. A bank account is deletable if it is not the primary bank account, or if it is the primary bank account but it is the only bank account for the contact.
      def deletable
        @raw["deletable"]
      end

      # Whether this bank account belongs to a contact or the merchant.
      def owner
        @raw["owner"]
      end

      # Whether this is the primary bank account for its owner (the contact or the merchant).
      def primary
        @raw["primary"]
      end

    end

    class FindBatchResult
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the batch.
      def batch_id
        @raw["batch_id"]
      end

      # The type of records in this batch.
      def type
        @raw["type"]
      end

      # The current processing status of the batch.
      def status
        @raw["status"]
      end

      # The URL to download the result xlsx file. Present when the batch has completed.
      def output_url
        @raw["output_url"]
      end

      # The URL to download the validated drafts JSON. Included after prepare has completed.
      def preview_url
        @raw["preview_url"]
      end

      # The failure reason when prepare or processing did not complete. Included when a background job failed.
      def error_message
        @raw["error_message"]
      end

      # The timestamp when the batch was created.
      def created_at
        @raw["created_at"]
      end

      # True when any payout in this batch is still in the requested state.
      def awaiting_authorization
        @raw["awaiting_authorization"]
      end

    end

    class FindCardResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the card.
      def card_id
        @raw["card_id"]
      end

      # The token of the card.
      def token
        @raw["token"]
      end

      # Whether the card token is for single or multiple use.
      def usage
        @raw["usage"]
      end

      # Whether the card token has been used.
      def used
        @raw["used"]
      end

      # The first 6 digits of the card number.
      def first_digits
        @raw["first_digits"]
      end

      # The last 2 digits of the card number.
      def last_digits
        @raw["last_digits"]
      end

      # The length of the card number.
      def length
        @raw["length"]
      end

      # The expiration date of the card (MM/YY format).
      def expiration_date
        @raw["expiration_date"]
      end

      # The name of the cardholder.
      def cardholder_name
        @raw["cardholder_name"]
      end

      # The card scheme (e.g., VISA, MASTERCARD).
      def scheme
        @raw["scheme"]
      end

      # The Unix timestamp (seconds since epoch) when the card was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the card was deleted.
      def deleted_at
        @raw["deleted_at"]
      end

      # Whether the card can be deleted. A card is deletable if it is not the default card, or if it is the default card but it is the only card for the contact.
      def deletable
        @raw["deletable"]
      end

    end

    class FindCommunicationDeliveryResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the queued communication delivery.
      def communication_delivery_id
        @raw["communication_delivery_id"]
      end

      # The communication channel used for this delivery.
      def communication_channel_id
        @raw["communication_channel_id"]
      end

      # The payment link sent to the recipient.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # How the message is delivered.
      def delivery
        @raw["delivery"]
      end

      # The email address or mobile number.
      def recipient
        @raw["recipient"]
      end

      # The contact matched by the recipient. Null when no contact matches.
      def contact_id
        @raw["contact_id"]
      end

      # The current delivery status. Accepted means the provider accepted the message.
      def status
        @raw["status"]
      end

      # When the delivery was queued.
      def created_at
        @raw["created_at"]
      end

      # When the provider accepted the message.
      def accepted_at
        @raw["accepted_at"]
      end

    end

    class DisputeEvidenceAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the evidence.
      def evidence_id
        @raw["evidence_id"]
      end

      # The stage of evidence.
      def stage
        @raw["stage"]
      end

      # A merchant comment for this evidence.
      def comment
        @raw["comment"]
      end

      # The name of the file attached to this evidence.
      def filename
        @raw["filename"]
      end

      # The MIME type of the file attached to this evidence.
      def content_type
        @raw["content_type"]
      end

      # The size of the file attached to this evidence in bytes.
      def byte_size
        @raw["byte_size"]
      end

      # Whether the evidence has been confirmed (uploaded).
      def submitted
        @raw["submitted"]
      end

      # The URL where the file can be uploaded (only present if not submitted).
      def upload_url
        @raw["upload_url"]
      end

      # The URL where the file can be downloaded (only present if submitted).
      def download_url
        @raw["download_url"]
      end

      # The (unix) timestamp when the evidence was created.
      def created_at
        @raw["created_at"]
      end

    end

    class FindDisputeResult
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the dispute.
      def dispute_id
        @raw["dispute_id"]
      end

      # The ID of the payment being disputed.
      def payment_id
        @raw["payment_id"]
      end

      # The ID of the contact who made the payment.
      def contact_id
        @raw["contact_id"]
      end

      # The human-readable reason for the dispute.
      def message
        @raw["message"]
      end

      # The overall status of the dispute.
      def status
        @raw["status"]
      end

      # The (unix) timestamp when the merchant submitted the challenge.
      def challenge_received_at
        @raw["challenge_received_at"]
      end

      # The (unix) timestamp when the merchant submitted the escalation.
      def escalation_received_at
        @raw["escalation_received_at"]
      end

      # The (unix) timestamp when the dispute was won.
      def won_at
        @raw["won_at"]
      end

      # The (unix) timestamp when the dispute was lost.
      def lost_at
        @raw["lost_at"]
      end

      # The disputed amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The reason code for the dispute.
      def reason
        @raw["reason"]
      end

      # A list of suggested evidence types for this dispute based on its reason.
      def suggested_evidence
        @raw["suggested_evidence"]
      end

      # The timestamp (Unix) by which a challenge or escalation is required. Failure to escalate or challenge will cause the dispute to be automatically closed in favor of the customer.
      def deadline_at
        @raw["deadline_at"]
      end

      # The timestamp when the dispute was created.
      def created_at
        @raw["created_at"]
      end

      # The fees associated with the dispute.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # Whether the dispute has been conceded by the merchant. This can be true only when the dispute is in the LOST state.
      def conceded
        @raw["conceded"]
      end

      # Whether the challenge fee is waived for this dispute.
      def challenge_fee_waived
        @raw["challenge_fee_waived"]
      end

      # The evidence submitted for this dispute.
      def evidences
        (@raw["evidences"] || []).map { |item| DisputeEvidenceAttributes.new(item) }
      end

      # The merchant ledger entries associated with this dispute.
      def entries
        (@raw["entries"] || []).map { |item| EntryAttributes.new(item) }
      end

    end

    class FindInstallationResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the installation.
      def installation_id
        @raw["installation_id"]
      end

      # Whether the installation is enabled and active.
      def enabled
        @raw["enabled"]
      end

      # The name of the installation.
      def name
        @raw["name"]
      end

      # The platform type of the installation (e.g., 'WEB', 'IOS', 'ANDROID', 'TERMINAL').
      def platform
        @raw["platform"]
      end

      # The unique identifier for the installation on the platform.
      def identifier
        @raw["identifier"]
      end

      # List of payment methods supported by this installation.
      def payment_methods
        (@raw["payment_methods"] || []).map { |item| PaymentMethodAttributes.new(item) }
      end

      # Email capture configuration for this installation. 'disabled' means no email collection, 'optional' means email is collected if provided by customer, 'required' means email is mandatory for all customers.
      def email_capture
        @raw["email_capture"]
      end

      # Mobile phone capture configuration for this installation. 'disabled' means no mobile number collection, 'optional' means mobile number is collected if provided by customer, 'required' means mobile number is mandatory for all customers.
      def mobile_capture
        @raw["mobile_capture"]
      end

      # Billing address capture configuration for this installation. 'disabled' means no billing address collection, 'optional' means billing address is collected if provided by customer, 'required' means billing address is mandatory for all customers.
      def address_capture
        @raw["address_capture"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

    end

    class FindInvoiceResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the invoice.
      def invoice_id
        @raw["invoice_id"]
      end

      # The full number of the invoice.
      def number
        @raw["number"]
      end

      # The status of the invoice.
      def status
        @raw["status"]
      end

      # The gross amount of the invoice in subunits.
      def amount
        @raw["amount"]
      end

      # The net amount of the invoice in subunits.
      def net_amount
        @raw["net_amount"]
      end

      # The VAT amount of the invoice in subunits.
      def vat_amount
        @raw["vat_amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The date the invoice was issued in ISO 8601 format.
      def issued_on
        @raw["issued_on"]
      end

      # The URL to download the invoice PDF.
      def pdf_download_url
        @raw["pdf_download_url"]
      end

      # The ID of the receipt associated with this invoice.
      def receipt_id
        @raw["receipt_id"]
      end

      # The full number of the receipt associated with this invoice.
      def receipt_number
        @raw["receipt_number"]
      end

      # The URL to download the receipt PDF.
      def receipt_pdf_download_url
        @raw["receipt_pdf_download_url"]
      end

      # The URL to download the receipt XML.
      def receipt_xml_download_url
        @raw["receipt_xml_download_url"]
      end

      # The creation timestamp of the receipt (Unix timestamp).
      def receipt_created_at
        @raw["receipt_created_at"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class FindKeyResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the key. This can be used as an argument to `find-key`.
      def key_id
        @raw["key_id"]
      end

      # The secret key. It will only be shown once as a response to `generate-key`. Subsequent calls using `find-key` will display `MASKED` instead.
      def key
        @raw["key"]
      end

      # The name of the key that you provided when creating it.
      def name
        @raw["name"]
      end

      # Whether the key is revoked. If it is revoked, it cannot be used to make API requests.
      def revoked
        @raw["revoked"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

      # Permission tokens granted to this key.
      def permissions
        @raw["permissions"]
      end

    end

    class FindPaymentResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment.
      def payment_id
        @raw["payment_id"]
      end

      # The merchant's internal reference for this payment.
      def external_id
        @raw["external_id"]
      end

      # The current status of the payment.
      def status
        @raw["status"]
      end

      # The payment amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The payment method used (e.g., 'PROMPTPAY', 'CARD').
      def payment_method
        @raw["payment_method"]
      end

      # The category of the payment method.
      def payment_method_category
        @raw["payment_method_category"]
      end

      # The display name of the payment method.
      def payment_method_display_name
        @raw["payment_method_display_name"]
      end

      # The first 6 digits of the card number. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_first_digits
        @raw["card_first_digits"]
      end

      # The last 2 digits of the card number. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_last_digits
        @raw["card_last_digits"]
      end

      # The card number with the first 6 and last 2 digits visible and the rest masked. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_masked_number
        @raw["card_masked_number"]
      end

      # The card network, such as visa or mastercard. Includes EDC payments, using the card the partner app reports at capture. Null for non-card payment methods or card payments without card details, such as an EDC payment before capture.
      def card_network
        @raw["card_network"]
      end

      # The cardholder's name as entered on the card. Null for non-card payment methods, card payments without card details, or when no name was entered. Always null for EDC payments, as the partner app only reports the card number digits.
      def cardholder_name
        @raw["cardholder_name"]
      end

      # The card's expiration date as captured, usually in MM/YY format. Null for non-card payment methods, card payments without card details, or when no expiration date was captured. Always null for EDC payments, as the partner app only reports the card number digits.
      def card_expiration_date
        @raw["card_expiration_date"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # When the payment was authorized (Unix timestamp).
      def authorized_at
        @raw["authorized_at"]
      end

      # When the payment was captured (Unix timestamp).
      def captured_at
        @raw["captured_at"]
      end

      # When the payment was voided (Unix timestamp).
      def voided_at
        @raw["voided_at"]
      end

      # When the payment was cancelled (Unix timestamp).
      def cancelled_at
        @raw["cancelled_at"]
      end

      # When the payment becomes eligible for refund (Unix timestamp). Present only while the payment is still within its void window.
      def refundable_at
        @raw["refundable_at"]
      end

      # When the payment expires (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # Whether the capture is automatic or manual.
      def capture
        @raw["capture"]
      end

      # The ID of the customer (contact) associated with this payment.
      def customer_id
        @raw["customer_id"]
      end

      # The merchant's external reference for the customer (contact), if set.
      def customer_external_id
        @raw["customer_external_id"]
      end

      # The email address of the customer.
      def customer_email
        @raw["customer_email"]
      end

      # The mobile phone number of the customer.
      def customer_mobile
        @raw["customer_mobile"]
      end

      # The name of the customer.
      def customer_name
        @raw["customer_name"]
      end

      # The fees associated with the payment.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # The first custom reference (e.g., invoice ID).
      def ref1
        @raw["ref1"]
      end

      # The second custom reference.
      def ref2
        @raw["ref2"]
      end

      # The third custom reference.
      def ref3
        @raw["ref3"]
      end

      # Whether the payment can be reversed.
      def reversible
        @raw["reversible"]
      end

      # Whether the payment can be captured.
      def capturable
        @raw["capturable"]
      end

      # Whether the payment can be voided.
      def voidable
        @raw["voidable"]
      end

      # Whether the payment can be cancelled.
      def cancellable
        @raw["cancellable"]
      end

      # Whether the payment can be refunded.
      def refundable
        @raw["refundable"]
      end

      # Whether the payment is considered risky or safe from a fraud perspective.
      def fraud_finding
        @raw["fraud_finding"]
      end

      # The failure code for a failed payment.
      def failure_code
        @raw["failure_code"]
      end

      # A description of why the payment failed
      def failure_message
        @raw["failure_message"]
      end

      # The ID of the terminal that created the payment, if any.
      def terminal_id
        @raw["terminal_id"]
      end

      # The ID of the payment link that created the payment, if any.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the payment session associated with this payment, if any.
      def payment_session_id
        @raw["payment_session_id"]
      end

      # The ID of the checkout associated with this payment, if any.
      def checkout_id
        @raw["checkout_id"]
      end

      # The number of monthly installments. Null for non-installment payments.
      def installment_term
        @raw["installment_term"]
      end

      # Who bears the installment interest. Null for non-installment payments.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The monthly interest rate of the installment plan as a percentage on a 0-100 scale (e.g. `1.5` means 1.5% per month), snapshotted when the payment method was selected. Not zeroed when the merchant bears the interest; see `interest_bearer`. Null for non-installment payments.
      def installment_interest_rate
        @raw["installment_interest_rate"]
      end

      # The total interest over the full term at the installment plan rate, in the smallest currency unit, snapshotted when the payment method was selected. Present for both interest bearers; `interest_bearer` says who pays it. Null for non-installment payments.
      def installment_interest_amount
        @raw["installment_interest_amount"]
      end

      # The name of the bank providing the installment plan. Null for non-installment payments.
      def installment_bank_name
        @raw["installment_bank_name"]
      end

      # The display name of the bank providing the installment plan. Null for non-installment payments.
      def installment_bank_display_name
        @raw["installment_bank_display_name"]
      end

    end

    class FindPaymentLinkResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payment link.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # The ID of the batch that created this payment link, if any.
      def batch_id
        @raw["batch_id"]
      end

      # The URL of the payment link.
      def payment_link_url
        @raw["payment_link_url"]
      end

      # The current status of the payment link.
      def status
        @raw["status"]
      end

      # The amount of the payment link in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The payment-link-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The description of the payment link.
      def description
        @raw["description"]
      end

      # The merchant's internal reference for this link.
      def external_id
        @raw["external_id"]
      end

      # When the link becomes invalid (Unix timestamp).
      def expires_at
        @raw["expires_at"]
      end

      # If true, the link expires after one successful payment.
      def single_use
        @raw["single_use"]
      end

      # Whether payments from this link are captured automatically. Installments and other payment methods that do not support authorization are always captured.
      def capture
        @raw["capture"]
      end

      # If true, sends a confirmation email to the customer after each successful payment.
      def send_confirmation_email
        @raw["send_confirmation_email"]
      end

      # The installation associated with this payment link.
      def installation
        (v = @raw["installation"]) && InstallationAttributes.new(v)
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

      # If true, the payment link has no associated payments and can be removed.
      def deletable
        @raw["deletable"]
      end

    end

    class FindPayoutResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the payout.
      def payout_id
        @raw["payout_id"]
      end

      # The external ID of the payout.
      def external_id
        @raw["external_id"]
      end

      # The current status of the payout.
      def status
        @raw["status"]
      end

      # The payout amount in subunits.
      def amount
        @raw["amount"]
      end

      # The currency code of the payout.
      def currency
        @raw["currency"]
      end

      # The timestamp when the payout was created.
      def created_at
        @raw["created_at"]
      end

      # The timestamp when the payout was settled/paid.
      def paid_at
        @raw["paid_at"]
      end

      # The timestamp when the payout was sent.
      def sent_at
        @raw["sent_at"]
      end

      # The ID of the bank account for the payout.
      def bank_account_id
        @raw["bank_account_id"]
      end

      # The bank code identifying the financial institution.
      def bank_code
        @raw["bank_code"]
      end

      # The bank account number.
      def bank_account_number
        @raw["bank_account_number"]
      end

      # The name of the account holder.
      def bank_account_name
        @raw["bank_account_name"]
      end

      # The ISO country code where the bank account is located.
      def bank_country_code
        @raw["bank_country_code"]
      end

      # The payout method name.
      def payout_method
        @raw["payout_method"]
      end

      # The mobile number for PromptPay payouts (when payout_method is mobile_number).
      def mobile_number
        @raw["mobile_number"]
      end

      # The national ID for PromptPay payouts (when payout_method is national_id).
      def national_id
        @raw["national_id"]
      end

      # The fees associated with the payout.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # The first custom reference (e.g., internal payout ID).
      def ref1
        @raw["ref1"]
      end

      # Whether this payout is awaiting secondary authorization before it can be processed.
      def needs_authorization
        @raw["needs_authorization"]
      end

      # The ID of the user who requested the payout (for user session-created payouts only).
      def requested_by_user_id
        @raw["requested_by_user_id"]
      end

      # The email address of the user who requested the payout (for user session-created payouts only).
      def requested_by_user_email
        @raw["requested_by_user_email"]
      end

      # The ID of the user who authorized the payout (applicable to contact payouts that require secondary authorization only).
      def authorized_by_user_id
        @raw["authorized_by_user_id"]
      end

      # The email address of the user who authorized the payout (applicable to contact payouts that require secondary authorization only).
      def authorized_by_user_email
        @raw["authorized_by_user_email"]
      end

      # The ID of the user who rejected the payout (applicable to contact payouts that require secondary authorization only).
      def rejected_by_user_id
        @raw["rejected_by_user_id"]
      end

      # The email address of the user who rejected the payout (applicable to contact payouts that require secondary authorization only).
      def rejected_by_user_email
        @raw["rejected_by_user_email"]
      end

    end

    class FindRefundResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the refund.
      def refund_id
        @raw["refund_id"]
      end

      # The merchant's internal reference for this refund.
      def external_id
        @raw["external_id"]
      end

      # The ID of the original payment.
      def payment_id
        @raw["payment_id"]
      end

      # The current status of the refund.
      def status
        @raw["status"]
      end

      # The refund amount in subunits.
      def amount
        @raw["amount"]
      end

      # The currency code of the refund.
      def currency
        @raw["currency"]
      end

      # When the refund was created.
      def created_at
        @raw["created_at"]
      end

      # When the refund was completed.
      def refunded_at
        @raw["refunded_at"]
      end

      # Whether the refund fully covers the original payment amount.
      def full
        @raw["full"]
      end

    end

    class FindTerminalResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the terminal.
      def terminal_id
        @raw["terminal_id"]
      end

      # Whether the terminal currently has an active device connection.
      def connected
        @raw["connected"]
      end

      # External identifier of the terminal (from your system).
      def external_id
        @raw["external_id"]
      end

      # The installation ID associated with this terminal, if any.
      def installation_id
        @raw["installation_id"]
      end

      # Human-readable name of the terminal.
      def name
        @raw["name"]
      end

      # Optional branch/store name this terminal belongs to.
      def branch_name
        @raw["branch_name"]
      end

      # Whether the terminal is enabled.
      def enabled
        @raw["enabled"]
      end

      # Whether the terminal is in kiosk mode.
      def kiosk_mode
        @raw["kiosk_mode"]
      end

      # When the device last verified, as a Unix timestamp. Null if never.
      def last_verified_at
        @raw["last_verified_at"]
      end

      # When the device last connected, as a Unix timestamp. Null if never.
      def connected_at
        @raw["connected_at"]
      end

      # The ID of the child terminal this terminal delegates payment display to, if any.
      def delegated_terminal_id
        @raw["delegated_terminal_id"]
      end

      # The ID of the parent terminal that delegates payment display to this terminal, if any.
      def parent_terminal_id
        @raw["parent_terminal_id"]
      end

      # One-time challenge to embed in the terminal QR code. Rotates after each successful device connection.
      def challenge
        @raw["challenge"]
      end

    end

    class FindTopupResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the topup.
      def topup_id
        @raw["topup_id"]
      end

      # The current status of the topup.
      def status
        @raw["status"]
      end

      # How the topup was funded. 'MANUAL' for a direct bank transfer, 'VIRTUAL_ACCOUNT' for funds received through a virtual account.
      def type
        @raw["type"]
      end

      # The topup amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The bank transaction reference for the incoming transfer.
      def transaction_id
        @raw["transaction_id"]
      end

      # The name on the sender's bank account.
      def sender_account_name
        @raw["sender_account_name"]
      end

      # The sender's bank account number.
      def sender_account_number
        @raw["sender_account_number"]
      end

      # The sender's 3-digit bank code.
      def sender_bank_code
        @raw["sender_bank_code"]
      end

      # The number of the virtual account that received the funds. Null for manual topups.
      def virtual_account_number
        @raw["virtual_account_number"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class FindVirtualAccountResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the virtual account.
      def virtual_account_id
        @raw["virtual_account_id"]
      end

      # The current state of the virtual account.
      def state
        @raw["state"]
      end

      # The bank-assigned virtual account number. Null until the account is opened.
      def number
        @raw["number"]
      end

      # The display name of the sponsoring bank for the virtual account (e.g., 'CIMB').
      def bank_name
        @raw["bank_name"]
      end

      # The virtual account display name registered with the bank.
      def display_name
        @raw["display_name"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class FindWebhookResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the webhook endpoint.
      def webhook_id
        @raw["webhook_id"]
      end

      # The name of the webhook endpoint.
      def name
        @raw["name"]
      end

      # Whether the webhook endpoint is enabled and will receive events.
      def enabled
        @raw["enabled"]
      end

      # The API version that the webhook endpoint is configured for.
      def api_version
        @raw["api_version"]
      end

      # The URL where webhook events will be sent.
      def destination_url
        @raw["destination_url"]
      end

      # The protocol used for sending webhook events (e.g., `HTTPS`).
      def protocol
        @raw["protocol"]
      end

      # The type of signature that will be sent in the header of webhooks.
      def signature_type
        @raw["signature_type"]
      end

      # The key used to verify webhook signatures.
      def verification_key
        @raw["verification_key"]
      end

      # List of event types that this webhook endpoint will receive.
      def events
        @raw["events"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

    end

    class GenerateBrandingUploadUrlResult
      def initialize(raw)
        @raw = raw
      end

      # The upload URL where files can be uploaded.
      def url
        @raw["url"]
      end

      # The ID of the upload session.
      def upload_id
        @raw["upload_id"]
      end

      # The HTTP headers required for the upload request.
      def headers
        @raw["headers"]
      end

    end

    class GenerateDisputeEvidenceUploadUrlResult
      def initialize(raw)
        @raw = raw
      end

      # The upload URL where files can be uploaded.
      def url
        @raw["url"]
      end

      # The ID of the upload session.
      def upload_id
        @raw["upload_id"]
      end

      # The HTTP headers required for the upload request.
      def headers
        @raw["headers"]
      end

    end

    class GenerateOnboardingUploadUrlResult
      def initialize(raw)
        @raw = raw
      end

      # The upload URL where files can be uploaded.
      def url
        @raw["url"]
      end

      # The ID of the upload session.
      def upload_id
        @raw["upload_id"]
      end

      # The HTTP headers required for the upload request.
      def headers
        @raw["headers"]
      end

    end

    class GenerateTemporaryTerminalChallengeResult
      def initialize(raw)
        @raw = raw
      end

      # Unique 8-digit challenge. Expires 5 minutes after it is generated.
      def temporary_challenge
        @raw["temporary_challenge"]
      end

      # Unix timestamp when the temporary challenge expires.
      def expires_at
        @raw["expires_at"]
      end

    end

    class GetBalanceResult
      def initialize(raw)
        @raw = raw
      end

      # The current balance amount in subunits.
      def amount
        @raw["amount"]
      end

      # The currency code of the balance.
      def currency
        @raw["currency"]
      end

    end

    class ActivityLogAttributes
      def initialize(raw)
        @raw = raw
      end

      # Unix timestamp when the activity was recorded.
      def created_at
        @raw["created_at"]
      end

      # The activity recorded in the log. Supported values:
      #
      # #### Activity Groups
      # * `dispute`: Includes all merchant-facing dispute status changes. Includes `dispute_challenged`, `dispute_escalated`, `dispute_conceded`.
      # * `payout`: Includes all merchant-facing payout activities. Includes `payout_created`, `payout_requested`, `payout_authorized`, `payout_rejected`.
      #
      # #### Individual Activities
      # * `communication_channel_activated`: A communication channel became active
      # * `dispute_challenged`: The dispute is being challenged by the merchant.
      # * `dispute_conceded`: The merchant has conceded the dispute.
      # * `dispute_escalated`: The dispute has been escalated to the provider.
      # * `invitation_accepted`: An invitation to join the merchant team was accepted.
      # * `payment_cancelled`: The payment was cancelled before it completed.
      # * `payment_captured`: The payment funds have been captured.
      # * `payment_reversed`: The payment was reversed (refunded or charged back).
      # * `payment_voided`: The payment was voided and will not be processed.
      # * `payout_authorized`: The payout has been authorized.
      # * `payout_created`: The payout record was created.
      # * `payout_rejected`: The payout was not authorized, and has been rejected.
      # * `payout_requested`: The payout has been requested and needs to be authorized.
      # * `plan_switched`: The merchant switched their subscription plan.
      # * `refund_created`: A refund request was created.
      # * `user_invited`: A new user was invited to the merchant team.
      # * `user_removed`: A user was removed from the merchant team.
      def activity_type
        @raw["activity_type"]
      end

      # Whether the action was performed by a dashboard user, an API key, or the system.
      def actor_type
        @raw["actor_type"]
      end

      # Email of the dashboard user who performed the action. Only set when actor_type is user. For internal admin actions, returns support@reservepay.com.
      def actor_email
        @raw["actor_email"]
      end

      # UID of the API key that performed the action. Only set when actor_type is api_key.
      def actor_key_id
        @raw["actor_key_id"]
      end

      # Type of the primary resource this activity relates to (e.g. payment, merchant).
      def parent_type
        @raw["parent_type"]
      end

      # ID of the primary resource this activity relates to.
      def parent_id
        @raw["parent_id"]
      end

      # ID of the object this activity is about (payment, refund, dispute, payout).
      def field_object_id
        @raw["object_id"]
      end

      # Type of the object this activity is about (e.g. payment, refund, dispute).
      def object_type
        @raw["object_type"]
      end

      # Email of the invited, removed, or accepting user. Only set for team activities.
      def user_email
        @raw["user_email"]
      end

      # Target plan UID after a plan change. Only set when activity_type is plan_switched.
      def new_plan_id
        @raw["new_plan_id"]
      end

      # Display name of the target plan after a plan change. Only set when activity_type is plan_switched.
      def new_plan_name
        @raw["new_plan_name"]
      end

      # Prior plan UID before a plan change. Only set when activity_type is plan_switched.
      def previous_plan_id
        @raw["previous_plan_id"]
      end

      # Display name of the prior plan before a plan change. Only set when activity_type is plan_switched.
      def previous_plan_name
        @raw["previous_plan_name"]
      end

    end

    class ApiRequestLogAttributes
      def initialize(raw)
        @raw = raw
      end

      # Unix timestamp when the API request was recorded.
      def created_at
        @raw["created_at"]
      end

      # HTTP status code returned for the request.
      def status
        @raw["status"]
      end

      # API endpoint identifier for the request.
      def endpoint
        @raw["endpoint"]
      end

      # Client IP address for the request.
      def ip_address
        @raw["ip_address"]
      end

      # Whether the request came from an API key or the merchant dashboard.
      def source
        @raw["source"]
      end

      # Email of the dashboard user who made the request. Only set when source is dashboard.
      def user_email
        @raw["user_email"]
      end

      # Human-readable browser and operating system parsed from the user agent sent with the request.
      def user_agent
        @raw["user_agent"]
      end

    end

    class BatchAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the batch.
      def batch_id
        @raw["batch_id"]
      end

      # The type of records in this batch.
      def type
        @raw["type"]
      end

      # The current processing status of the batch.
      def status
        @raw["status"]
      end

      # The URL to download the result xlsx file. Present when the batch has completed.
      def output_url
        @raw["output_url"]
      end

      # The URL to download the validated drafts JSON. Included after prepare has completed.
      def preview_url
        @raw["preview_url"]
      end

      # The failure reason when prepare or processing did not complete. Included when a background job failed.
      def error_message
        @raw["error_message"]
      end

      # The timestamp when the batch was created.
      def created_at
        @raw["created_at"]
      end

      # True when any payout in this batch is still in the requested state.
      def awaiting_authorization
        @raw["awaiting_authorization"]
      end

    end

    class CommunicationChannelAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the communication channel.
      def communication_channel_id
        @raw["communication_channel_id"]
      end

      # How messages are delivered on this channel.
      def delivery
        @raw["delivery"]
      end

      # The from-address for an email channel. Null for SMS.
      def email
        @raw["email"]
      end

      # The sender name for an SMS channel. Null for email.
      def sender_name
        @raw["sender_name"]
      end

      # Whether this channel is the active channel for its delivery.
      def active
        @raw["active"]
      end

      # The channel status. Custom email stays `pending_setup` until setup is confirmed.
      def status
        @raw["status"]
      end

    end

    class DisputeAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the dispute.
      def dispute_id
        @raw["dispute_id"]
      end

      # The ID of the payment being disputed.
      def payment_id
        @raw["payment_id"]
      end

      # The ID of the contact who made the payment.
      def contact_id
        @raw["contact_id"]
      end

      # The human-readable reason for the dispute.
      def message
        @raw["message"]
      end

      # The overall status of the dispute.
      def status
        @raw["status"]
      end

      # The (unix) timestamp when the merchant submitted the challenge.
      def challenge_received_at
        @raw["challenge_received_at"]
      end

      # The (unix) timestamp when the merchant submitted the escalation.
      def escalation_received_at
        @raw["escalation_received_at"]
      end

      # The (unix) timestamp when the dispute was won.
      def won_at
        @raw["won_at"]
      end

      # The (unix) timestamp when the dispute was lost.
      def lost_at
        @raw["lost_at"]
      end

      # The disputed amount in subunits.
      def amount
        @raw["amount"]
      end

      # The 3-letter ISO currency code.
      def currency
        @raw["currency"]
      end

      # The reason code for the dispute.
      def reason
        @raw["reason"]
      end

      # A list of suggested evidence types for this dispute based on its reason.
      def suggested_evidence
        @raw["suggested_evidence"]
      end

      # The timestamp (Unix) by which a challenge or escalation is required. Failure to escalate or challenge will cause the dispute to be automatically closed in favor of the customer.
      def deadline_at
        @raw["deadline_at"]
      end

      # The timestamp when the dispute was created.
      def created_at
        @raw["created_at"]
      end

      # The fees associated with the dispute.
      def fees
        (@raw["fees"] || []).map { |item| FeeAttributes.new(item) }
      end

      # Whether the dispute has been conceded by the merchant. This can be true only when the dispute is in the LOST state.
      def conceded
        @raw["conceded"]
      end

      # Whether the challenge fee is waived for this dispute.
      def challenge_fee_waived
        @raw["challenge_fee_waived"]
      end

      # The evidence submitted for this dispute.
      def evidences
        (@raw["evidences"] || []).map { |item| DisputeEvidenceAttributes.new(item) }
      end

      # The merchant ledger entries associated with this dispute.
      def entries
        (@raw["entries"] || []).map { |item| EntryAttributes.new(item) }
      end

    end

    class NotificationTopicAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the notification topic.
      def id
        @raw["id"]
      end

      # The name of the notification topic.
      def name
        @raw["name"]
      end

      # The display name of the notification topic.
      def display_name
        @raw["display_name"]
      end

      # The category of the notification topic.
      def category
        @raw["category"]
      end

    end

    class EmailRecipientAttributes
      def initialize(raw)
        @raw = raw
      end

      # The email address subscribed to notifications.
      def email
        @raw["email"]
      end

      # The language for notifications sent to this email address.
      def language
        @raw["language"]
      end

      # The notification topic this email is subscribed to.
      def notification_topics
        (@raw["notification_topics"] || []).map { |item| NotificationTopicAttributes.new(item) }
      end

    end

    class ListInstallmentIssuersResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the installment issuer. Use it as `issuer_id` with `filter-payments`.
      def issuer_id
        @raw["issuer_id"]
      end

      # The display name of the installment issuer, as configured in admin.
      def display_name
        @raw["display_name"]
      end

    end

    class InvoiceAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the invoice.
      def invoice_id
        @raw["invoice_id"]
      end

      # The full number of the invoice.
      def number
        @raw["number"]
      end

      # The status of the invoice.
      def status
        @raw["status"]
      end

      # The gross amount of the invoice in subunits.
      def amount
        @raw["amount"]
      end

      # The net amount of the invoice in subunits.
      def net_amount
        @raw["net_amount"]
      end

      # The VAT amount of the invoice in subunits.
      def vat_amount
        @raw["vat_amount"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The date the invoice was issued in ISO 8601 format.
      def issued_on
        @raw["issued_on"]
      end

      # The URL to download the invoice PDF.
      def pdf_download_url
        @raw["pdf_download_url"]
      end

      # The ID of the receipt associated with this invoice.
      def receipt_id
        @raw["receipt_id"]
      end

      # The full number of the receipt associated with this invoice.
      def receipt_number
        @raw["receipt_number"]
      end

      # The URL to download the receipt PDF.
      def receipt_pdf_download_url
        @raw["receipt_pdf_download_url"]
      end

      # The URL to download the receipt XML.
      def receipt_xml_download_url
        @raw["receipt_xml_download_url"]
      end

      # The creation timestamp of the receipt (Unix timestamp).
      def receipt_created_at
        @raw["receipt_created_at"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class KeyAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the key. This can be used as an argument to `find-key`.
      def key_id
        @raw["key_id"]
      end

      # The secret key. It will only be shown once as a response to `generate-key`. Subsequent calls using `find-key` will display `MASKED` instead.
      def key
        @raw["key"]
      end

      # The name of the key that you provided when creating it.
      def name
        @raw["name"]
      end

      # Whether the key is revoked. If it is revoked, it cannot be used to make API requests.
      def revoked
        @raw["revoked"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

      # Permission tokens granted to this key.
      def permissions
        @raw["permissions"]
      end

    end

    class MetadataAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique key that identifies the metadata object.
      def key
        @raw["key"]
      end

      # The stored JSON metadata.
      def metadata
        @raw["metadata"]
      end

      # The size of the metadata in bytes.
      def bytesize
        @raw["bytesize"]
      end

      # The current version number (lock_version).
      def version
        @raw["version"]
      end

      # The Unix timestamp (seconds since epoch) when the metadata was last updated.
      def updated_at
        @raw["updated_at"]
      end

      # The Unix timestamp (seconds since epoch) when the metadata was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the metadata will expire. May be null.
      def expires_at
        @raw["expires_at"]
      end

    end

    class MonthlyBillingArchiveAttributes
      def initialize(raw)
        @raw = raw
      end

      # The identifying month and year of the billing archive in 'YYYY-MM' format.
      def id
        @raw["id"]
      end

      # The download URL where the archive can be downloaded.
      def url
        @raw["url"]
      end

    end

    class EventDeliveryAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the event.
      def event_id
        @raw["event_id"]
      end

      # The unique identifier of the event delivery.
      def event_delivery_id
        @raw["event_delivery_id"]
      end

      # HTTP status code returned by the webhook endpoint during delivery attempt.
      def status_code
        @raw["status_code"]
      end

      # Specific failure code if the delivery failed. Null if delivery was successful.
      def failure_code
        @raw["failure_code"]
      end

      # The webhook URL where the event was delivered.
      def url
        @raw["url"]
      end

      # Number of delivery attempts made for this event.
      def occurrences
        @raw["occurrences"]
      end

      # Unix timestamp indicating when the event delivery was created.
      def created_at
        @raw["created_at"]
      end

      # The complete event document that was sent to the webhook endpoint.
      # Contains all the event data including payment information and metadata.
      def payload
        @raw["payload"]
      end

    end

    class PaymentActivityAttributes
      def initialize(raw)
        @raw = raw
      end

      # Unix timestamp indicating when the activity was created.
      def created_at
        @raw["created_at"]
      end

      # The type of activity that was performed. Supported values:
      #
      # * `dispute_lost`: The dispute was resolved in favor of the customer.
      # * `dispute_opened`: A new dispute has been opened by the customer.
      # * `dispute_reopened`: The dispute has been reopened.
      # * `dispute_won`: The dispute was resolved in favor of the merchant.
      # * `payment_authorized`: The payment was authorized by the provider.
      # * `payment_cancelled`: The payment was cancelled before it completed.
      # * `payment_checked_out`: The customer completed the checkout process.
      # * `payment_completed`: The payment was successfully completed.
      # * `payment_created`: The payment record was created in the system.
      # * `payment_redirect_url_accessed`: The customer was redirected to the payment provider.
      # * `payment_reversed`: The payment was reversed (refunded or charged back).
      # * `payment_selected`: The payment method was selected by the customer.
      # * `payment_voided`: The payment was voided and will not be processed.
      # * `refund_completed`: The refund was successfully completed.
      # * `refund_created`: A refund request was created.
      # * `refund_failed`: The refund attempt failed.
      # * `refund_initiated`: The refund process has been initiated.
      def activity
        @raw["activity"]
      end

      # The URL path where the activity occurred.
      def path
        @raw["path"]
      end

      # The IP address of the client that initiated the activity.
      def ip_address
        @raw["ip_address"]
      end

      # The severity level of the activity log (INFO, WARN, ERROR).
      def severity
        @raw["severity"]
      end

      # Request information for log activities (not events).
      # Contains details about the original request that generated this activity.
      def request
        @raw["request"]
      end

      # Response information for log activities (not events).
      # Contains details about the response that was generated for this activity.
      def response
        @raw["response"]
      end

      # Array of event delivery objects containing webhook delivery information.
      # Only present for activities that are events with associated webhook deliveries.
      def event_deliveries
        (@raw["event_deliveries"] || []).map { |item| EventDeliveryAttributes.new(item) }
      end

      # The status of the payment at the time of the activity.
      def payment_status
        @raw["payment_status"]
      end

    end

    class ListPayoutActivitiesResult
      def initialize(raw)
        @raw = raw
      end

      # Unix timestamp indicating when the activity was created.
      def created_at
        @raw["created_at"]
      end

      # The type of activity that was performed. Supported values:
      #
      # * `payout_authorized`: The payout has been authorized.
      # * `payout_completed`: The payout was successfully completed.
      # * `payout_created`: The payout record was created.
      # * `payout_rejected`: The payout was not authorized, and has been rejected.
      # * `payout_requested`: The payout has been requested and needs to be authorized.
      def activity
        @raw["activity"]
      end

      # The URL path where the activity occurred.
      def path
        @raw["path"]
      end

      # The IP address of the client that initiated the activity.
      def ip_address
        @raw["ip_address"]
      end

      # The severity level of the activity log (INFO, WARN, ERROR).
      def severity
        @raw["severity"]
      end

      # Request information for log activities (not events).
      # Contains details about the original request that generated this activity.
      def request
        @raw["request"]
      end

      # Response information for log activities (not events).
      # Contains details about the response that was generated for this activity.
      def response
        @raw["response"]
      end

      # Array of event delivery objects containing webhook delivery information.
      # Only present for activities that are events with associated webhook deliveries.
      def event_deliveries
        (@raw["event_deliveries"] || []).map { |item| EventDeliveryAttributes.new(item) }
      end

      # The status of the payout at the time of the activity.
      def payout_status
        @raw["payout_status"]
      end

    end

    class PlannedMaintenanceAttributes
      def initialize(raw)
        @raw = raw
      end

      # Unique identifier of the planned maintenance window.
      def id
        @raw["id"]
      end

      # Name of the service undergoing maintenance, in the requested locale.
      def service_name
        @raw["service_name"]
      end

      # Services affected by the maintenance window.
      def affected_services
        @raw["affected_services"]
      end

      # Current lifecycle status of the planned maintenance window.
      def status
        @raw["status"]
      end

      # Scheduled start time as a Unix timestamp.
      def start_at
        @raw["start_at"]
      end

      # Scheduled end time as a Unix timestamp.
      def end_at
        @raw["end_at"]
      end

      # Category of expected service impact during the maintenance window.
      def expected_impact
        @raw["expected_impact"]
      end

      # Description of the expected service impact, in the requested locale.
      def expected_impact_description
        @raw["expected_impact_description"]
      end

      # Detailed description of the maintenance purpose, in the requested locale.
      def purpose
        @raw["purpose"]
      end

      # Action required by merchants or partners during the maintenance window.
      def action_required
        @raw["action_required"]
      end

    end

    class PlanSkuAttributes
      def initialize(raw)
        @raw = raw
      end

      # The code of the SKU.
      def code
        @raw["code"]
      end

      # The category of the SKU. I.e. what type of billable it applies to.
      def category
        @raw["category"]
      end

      # The unit price of the SKU. Each billable item is charged this amount.
      def unit_price
        @raw["unit_price"]
      end

      # The percentage fee of the SKU. Each billable item is charged this percentage of its billable amount. E.g. for payments and payouts, that's the percentage of the payment `amount`.
      def percentage_fee
        @raw["percentage_fee"]
      end

      # How unit_price and percentage_fee are combined into a fee for daily statements.
      #
      # - SUM: Both are charged.
      # - HIGHER_OF: The higher of the two is charged. I.e. unit_price acts as a minimum. E.g. 3% with a minimum fee of 10 THB.
      # - LOWER_OF: The lower of the two is charged. I.e. unit_price acts as a maximum. E.g. 3% with a maximum fee of 10 THB.
      def fee_calculation_method
        @raw["fee_calculation_method"]
      end

      # The discounted unit price, if any. When present and applicable, replaces `unit_price`. Conditions may apply.
      def discount_unit_price
        @raw["discount_unit_price"]
      end

      # The discounted percentage fee, if any. When present and applicable, replaces `percentage_fee`. Conditions may apply.
      def discount_percentage_fee
        @raw["discount_percentage_fee"]
      end

      # The minimum billable amount for the discount to apply. E.g. 0 THB fee on payments over `1000 THB`. Null when no minimum applies.
      def discount_minimum_billable_amount
        @raw["discount_minimum_billable_amount"]
      end

      # The maximum billable amount for the discount to apply. E.g. 0 THB fee on payments under `1000 THB`. Null when no maximum applies.
      def discount_maximum_billable_amount
        @raw["discount_maximum_billable_amount"]
      end

      # How many times per month this discount can be applied per merchant account. Follows calendar months. Null when no limit applies.
      def discount_maximum_monthly_uses
        @raw["discount_maximum_monthly_uses"]
      end

      # Whether this discount shares its `discount_maximum_monthly_uses` with other SKUs of the same `category`.
      def discount_shared_monthly_uses
        @raw["discount_shared_monthly_uses"]
      end

    end

    class PlanAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the plan.
      def id
        @raw["id"]
      end

      # The code representing the tier this plan belongs to.
      def tier_code
        @raw["tier_code"]
      end

      # The name of the tier (e.g., 'Basic', 'Pro').
      def tier_name
        @raw["tier_name"]
      end

      # List of features included in this plan.
      def features
        @raw["features"]
      end

      # The date and time when the plan was last revised.
      def revision_time
        @raw["revision_time"]
      end

      # Indicates whether the plan can be selected by the merchant via self-service.
      def selectable
        @raw["selectable"]
      end

      # The ordering of the plan's tier. Selecting a plan whose rank is greater than or equal to the current plan's rank takes effect immediately; selecting a lower rank is scheduled for the start of the next billing month.
      def rank
        @raw["rank"]
      end

      # List of SKUs the merchant is billed with on this plan. A merchant's custom SKU for this plan's tier replaces the plan SKU with the same `code`, and custom SKUs for codes the plan does not have are included. Empty when the plan has no `id`.
      def skus
        (@raw["skus"] || []).map { |item| PlanSkuAttributes.new(item) }
      end

    end

    class RefundAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the refund.
      def refund_id
        @raw["refund_id"]
      end

      # The merchant's internal reference for this refund.
      def external_id
        @raw["external_id"]
      end

      # The ID of the original payment.
      def payment_id
        @raw["payment_id"]
      end

      # The current status of the refund.
      def status
        @raw["status"]
      end

      # The refund amount in subunits.
      def amount
        @raw["amount"]
      end

      # The currency code of the refund.
      def currency
        @raw["currency"]
      end

      # When the refund was created.
      def created_at
        @raw["created_at"]
      end

      # When the refund was completed.
      def refunded_at
        @raw["refunded_at"]
      end

      # Whether the refund fully covers the original payment amount.
      def full
        @raw["full"]
      end

    end

    class RoleAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the role.
      def id
        @raw["id"]
      end

      # The name of the role.
      def name
        @raw["name"]
      end

      # A brief description of the role's purpose and permissions.
      def description
        @raw["description"]
      end

      # Indicates whether the role is a custom role created by the merchant or a default system role.
      def custom
        @raw["custom"]
      end

      # An array of permissions the role gives.
      def permissions
        @raw["permissions"]
      end

    end

    class StatementAttributes
      def initialize(raw)
        @raw = raw
      end

      # The date this statement covers in ISO 8601 format.
      def date
        @raw["date"]
      end

      # The total payment amount for this statement.
      def payment_amount
        @raw["payment_amount"]
      end

      # The total number of payments for this statement.
      def payment_count
        @raw["payment_count"]
      end

      # The total refund amount for this statement.
      def refund_amount
        @raw["refund_amount"]
      end

      # The total number of refunds for this statement.
      def refund_count
        @raw["refund_count"]
      end

      # The total dispute amount for this statement.
      def dispute_amount
        @raw["dispute_amount"]
      end

      # The total number of disputes for this statement.
      def dispute_count
        @raw["dispute_count"]
      end

      # The total payout amount for this statement.
      def payout_amount
        @raw["payout_amount"]
      end

      # The total number of payouts for this statement.
      def payout_count
        @raw["payout_count"]
      end

      # The total fees for this statement.
      def fees
        @raw["fees"]
      end

      # The total net transaction volume for this statement, excluding payouts.
      def net_transaction_volume
        @raw["net_transaction_volume"]
      end

      # The total invoice amount for this statement.
      def invoice_amount
        @raw["invoice_amount"]
      end

      # The status of the invoice. Unbilled if no invoice was issued.
      def invoice_status
        @raw["invoice_status"]
      end

      # The URL to download the invoice PDF for this statement. Blank if the invoice was not yet issued.
      def invoice_pdf_download_url
        @raw["invoice_pdf_download_url"]
      end

      # The ID of the invoice. Blank if the invoice was not yet issued.
      def invoice_id
        @raw["invoice_id"]
      end

      # The change in balance for this statement.
      def change_in_balance
        @raw["change_in_balance"]
      end

      # The URL to download the CSV for this statement.
      def csv_download_url
        @raw["csv_download_url"]
      end

      # The URL to download the PDF for this statement.
      def pdf_download_url
        @raw["pdf_download_url"]
      end

    end

    class InvitationAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the invitation. This can be used as an argument in other endpoints. E.g.: `remove-invitation`
      def invitation_id
        @raw["invitation_id"]
      end

      # The email address the invitation was sent to.
      def email
        @raw["email"]
      end

      # The ID of the role assigned to the user in the invitation.
      def role_id
        @raw["role_id"]
      end

      # The ID of the user who sent the invitation.
      def inviter_id
        @raw["inviter_id"]
      end

    end

    class MerchantMembershipAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the user. This can be used as an argument in other endpoints. E.g.: `remove-user`
      def user_id
        @raw["user_id"]
      end

      # The name of the user, as they set it in their profile. This name is informational only and has not been verified.
      def name
        @raw["name"]
      end

      # The email address of the user.
      def email
        @raw["email"]
      end

      # Whether the user's email address has been confirmed. If it is `false`, they may not own this address, and their access will be limited.
      def email_confirmed
        @raw["email_confirmed"]
      end

      # Whether the user has enabled multi-factor authentication (MFA) for their account. This is set by the user in their profile settings.
      def mfa_enabled
        @raw["mfa_enabled"]
      end

      # The ID of the user's role within the merchant account. This can be used as an argument in other endpoints.
      def role_id
        @raw["role_id"]
      end

      # The user's preferred language for communication. This is set by the user in their profile settings.
      def preferred_language
        @raw["preferred_language"]
      end

    end

    class VirtualAccountAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the virtual account.
      def virtual_account_id
        @raw["virtual_account_id"]
      end

      # The current state of the virtual account.
      def state
        @raw["state"]
      end

      # The bank-assigned virtual account number. Null until the account is opened.
      def number
        @raw["number"]
      end

      # The display name of the sponsoring bank for the virtual account (e.g., 'CIMB').
      def bank_name
        @raw["bank_name"]
      end

      # The virtual account display name registered with the bank.
      def display_name
        @raw["display_name"]
      end

      # The 3-letter ISO currency code (e.g., 'THB').
      def currency
        @raw["currency"]
      end

      # The creation timestamp (Unix timestamp).
      def created_at
        @raw["created_at"]
      end

    end

    class WebhookAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the webhook endpoint.
      def webhook_id
        @raw["webhook_id"]
      end

      # The name of the webhook endpoint.
      def name
        @raw["name"]
      end

      # Whether the webhook endpoint is enabled and will receive events.
      def enabled
        @raw["enabled"]
      end

      # The API version that the webhook endpoint is configured for.
      def api_version
        @raw["api_version"]
      end

      # The URL where webhook events will be sent.
      def destination_url
        @raw["destination_url"]
      end

      # The protocol used for sending webhook events (e.g., `HTTPS`).
      def protocol
        @raw["protocol"]
      end

      # The type of signature that will be sent in the header of webhooks.
      def signature_type
        @raw["signature_type"]
      end

      # The key used to verify webhook signatures.
      def verification_key
        @raw["verification_key"]
      end

      # List of event types that this webhook endpoint will receive.
      def events
        @raw["events"]
      end

      # The timestamp of the key creation as a Unix timestamp.
      def created_at
        @raw["created_at"]
      end

    end

    class RetrieveBrandingResult
      def initialize(raw)
        @raw = raw
      end

      # Primary color used for buttons and main elements (hex format).
      def primary_color
        @raw["primary_color"]
      end

      # Secondary color used for backgrounds and accents (hex format).
      def secondary_color
        @raw["secondary_color"]
      end

      # Background color for the sidebar (hex format).
      def sidebar_color
        @raw["sidebar_color"]
      end

      # The type of sidebar background to use (color or image).
      def sidebar_background_type
        @raw["sidebar_background_type"]
      end

      # Whether to tile the sidebar image to fill the entire sidebar area.
      def tile_sidebar_image
        @raw["tile_sidebar_image"]
      end

      # Whether to hide the logo completely from the payment interface.
      def hide_logo
        @raw["hide_logo"]
      end

      # Font family for the shop name shown when no logo is displayed.
      def shop_name_font_family
        @raw["shop_name_font_family"]
      end

      # Font weight variant for the shop name.
      def shop_name_font_variant
        @raw["shop_name_font_variant"]
      end

      # Font family for headings.
      def heading_font_family
        @raw["heading_font_family"]
      end

      # Font weight variant for headings.
      def heading_font_variant
        @raw["heading_font_variant"]
      end

      # Font family for body text.
      def body_font_family
        @raw["body_font_family"]
      end

      # Font weight variant for body text.
      def body_font_variant
        @raw["body_font_variant"]
      end

      # Whether to use ISO currency codes instead of currency symbols.
      def use_iso_code
        @raw["use_iso_code"]
      end

      # Whether to hide decimal places when they are zero.
      def hide_non_significant_zeros
        @raw["hide_non_significant_zeros"]
      end

      # Whether to display the payment amount in the button text.
      def show_amount_in_button
        @raw["show_amount_in_button"]
      end

      # Where to place the currency symbol relative to the amount.
      def symbol_placement
        @raw["symbol_placement"]
      end

      # Default text displayed on payment buttons.
      def default_button_text
        @raw["default_button_text"]
      end

      # Border radius style for buttons.
      def button_shape
        @raw["button_shape"]
      end

      # URL for the light logo (for light backgrounds).
      def light_logo_url
        @raw["light_logo_url"]
      end

      # Upload ID for the light logo. Use this ID with remove-branding-document to remove the logo.
      def light_logo_id
        @raw["light_logo_id"]
      end

      # Original filename of the uploaded light logo.
      def light_logo_filename
        @raw["light_logo_filename"]
      end

      # MIME type of the light logo file (e.g., 'image/png', 'image/jpeg').
      def light_logo_file_type
        @raw["light_logo_file_type"]
      end

      # URL for the dark logo (for dark backgrounds).
      def dark_logo_url
        @raw["dark_logo_url"]
      end

      # Upload ID for the dark logo. Use this ID with remove-branding-document to remove the logo.
      def dark_logo_id
        @raw["dark_logo_id"]
      end

      # Original filename of the uploaded dark logo.
      def dark_logo_filename
        @raw["dark_logo_filename"]
      end

      # MIME type of the dark logo file (e.g., 'image/png', 'image/jpeg').
      def dark_logo_file_type
        @raw["dark_logo_file_type"]
      end

      # URL for the sidebar background image.
      def sidebar_image_url
        @raw["sidebar_image_url"]
      end

      # Upload ID for the sidebar image. Use this ID with remove-branding-document to remove the image.
      def sidebar_image_id
        @raw["sidebar_image_id"]
      end

      # Original filename of the uploaded sidebar image.
      def sidebar_image_filename
        @raw["sidebar_image_filename"]
      end

      # MIME type of the sidebar image file (e.g., 'image/png', 'image/jpeg').
      def sidebar_image_file_type
        @raw["sidebar_image_file_type"]
      end

    end

    class RetrieveBrandingFontResult
      def initialize(raw)
        @raw = raw
      end

      # The font family name (e.g., 'Noto Sans', 'Roboto').
      def family
        @raw["family"]
      end

      # The font category that describes the font style and usage.
      def category
        @raw["category"]
      end

      # Available font weight variants for this font family.
      def variants
        @raw["variants"]
      end

    end

    class RetrieveCheckoutResult
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier for the checkout
      def checkout_id
        @raw["checkout_id"]
      end

      # The payment amount in the smallest currency unit (e.g. cents).
      def amount
        @raw["amount"]
      end

      # The currency code for the payment amount
      def currency
        @raw["currency"]
      end

      # The checkout-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The unique identifier of the merchant installation associated with this checkout
      def installation_id
        @raw["installation_id"]
      end

      # The unique identifier of the customer making the payment
      def customer_id
        @raw["customer_id"]
      end

      # The email address of the customer
      def customer_email
        @raw["customer_email"]
      end

      # The mobile phone number of the customer
      def customer_mobile
        @raw["customer_mobile"]
      end

      # The name of the customer
      def customer_name
        @raw["customer_name"]
      end

      # The merchant's internal reference for this checkout. Copied onto the payment when the customer pays.
      def external_id
        @raw["external_id"]
      end

      # The URL where the customer will be redirected to make payment
      def redirect_url
        @raw["redirect_url"]
      end

      # The unique identifier of the payment associated with this checkout. When nil, the payment has not been paid yet.
      def payment_id
        @raw["payment_id"]
      end

    end

    class MerchantConfigurationAttributes
      def initialize(raw)
        @raw = raw
      end

      # The base/default currency for the merchant account.
      def funding_currency
        @raw["funding_currency"]
      end

      # The merchant timezone as an IANA timezone string. E.g. `Asia/Bangkok`
      def time_zone
        @raw["time_zone"]
      end

      # The merchant timezone (ISO8601 format). E.g.: +07:00
      def time_offset
        @raw["time_offset"]
      end

      # The global baseline minimum amount for automated payouts. The actual required minimum for a specific transaction may be higher depending on the rules or limits of the chosen payout method.
      def minimum_automated_payout_amount
        @raw["minimum_automated_payout_amount"]
      end

      # The global baseline maximum amount for automated payouts. The actual allowed maximum for a specific transaction may be lower depending on the rules or limits of the chosen payout method.
      def maximum_automated_payout_amount
        @raw["maximum_automated_payout_amount"]
      end

      # The payout amount threshold that triggers the PO-HIGH_VALUE Plan SKU. This SKU is applied instead of other payout SKUs.
      def high_value_payout_threshold_amount
        @raw["high_value_payout_threshold_amount"]
      end

      # Whether payouts are blocked for this merchant.
      def payouts_blocked
        @raw["payouts_blocked"]
      end

    end

    class RetrieveContactResult
      def initialize(raw)
        @raw = raw
      end

      # The internal unique identifier for the contact.
      def contact_id
        @raw["contact_id"]
      end

      # The external ID provided when the contact was created.
      def external_id
        @raw["external_id"]
      end

      # The email address of the contact.
      def email
        @raw["email"]
      end

      # The mobile number of the contact.
      def mobile
        @raw["mobile"]
      end

      # The name of the contact.
      def name
        @raw["name"]
      end

      # Whether the contact is marked as a favorite.
      def favorite
        @raw["favorite"]
      end

      # The Unix timestamp (seconds since epoch) when the contact was created.
      def created_at
        @raw["created_at"]
      end

      # The primary bank account for the contact.
      def primary_bank_account
        (v = @raw["primary_bank_account"]) && BankAccountAttributes.new(v)
      end

      # The default card for the contact.
      def default_card
        (v = @raw["default_card"]) && CardAttributes.new(v)
      end

      # The most recent bank accounts associated with the contact (limited to 25 most recent, ordered by creation date descending).
      def bank_accounts
        (@raw["bank_accounts"] || []).map { |item| BankAccountAttributes.new(item) }
      end

      # The most recent cards associated with the contact (limited to 25 most recent, ordered by creation date descending).
      def cards
        (@raw["cards"] || []).map { |item| CardAttributes.new(item) }
      end

    end

    class CurrentPlanAttributes
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier of the plan.
      def id
        @raw["id"]
      end

      # The code representing the tier this plan belongs to.
      def tier_code
        @raw["tier_code"]
      end

      # The name of the tier (e.g., 'Basic', 'Pro').
      def tier_name
        @raw["tier_name"]
      end

      # List of features included in this plan.
      def features
        @raw["features"]
      end

      # The date and time when the plan was last revised.
      def revision_time
        @raw["revision_time"]
      end

      # Indicates whether the plan can be selected by the merchant via self-service.
      def selectable
        @raw["selectable"]
      end

      # The ordering of the plan's tier. Selecting a plan whose rank is greater than or equal to the current plan's rank takes effect immediately; selecting a lower rank is scheduled for the start of the next billing month.
      def rank
        @raw["rank"]
      end

      # List of SKUs the merchant is billed with on this plan. A merchant's custom SKU for this plan's tier replaces the plan SKU with the same `code`, and custom SKUs for codes the plan does not have are included. Empty when the plan has no `id`.
      def skus
        (@raw["skus"] || []).map { |item| PlanSkuAttributes.new(item) }
      end

      # The identifier of the plan a scheduled change will promote to, or `null` when no change is scheduled. Only downgrades are ever scheduled; upgrades are promoted immediately.
      def pending_plan_id
        @raw["pending_plan_id"]
      end

    end

    class RetrieveDisputePerformanceResult
      def initialize(raw)
        @raw = raw
      end

      # The start date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the beginning of the date range for which performance data is calculated.
      # For single day requests, this will be the same as end_date.
      def start_date
        @raw["start_date"]
      end

      # The end date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the end of the date range for which performance data is calculated.
      # For single day requests, this will be the same as start_date.
      def end_date
        @raw["end_date"]
      end

      # The total amount of all captured transactions in the period, expressed in the smallest currency unit. E.g. 100 THB is represented as 10000. And 100 JPY is represented as 100.
      def amount
        @raw["amount"]
      end

      # The total number of captured transactions in the period.
      def count
        @raw["count"]
      end

      # The average captured transaction amount in the smallest currency unit.
      def average
        @raw["average"]
      end

      # The percentage change in total amount compared to the previous equivalent period.
      #
      # **Values:**
      #
      # - **Positive**: Indicates an increase in compared to the previous period
      # - **Negative**: Indicates a decrease in compared to the previous period
      # - **Null**: When there are no transactions in the previous period (division by zero)
      #
      # **Example:** A value of 15.5 means increased by 15.5% compared to the previous period.
      def change
        @raw["change"]
      end

      # The time granularity used for transaction breakdown in the response.
      #
      # **Granularity is determined by the date range:**
      #
      # - **hourly**: Single day requests (0 days)
      # - **daily**: 1-83 days range
      # - **weekly**: 84-167 days range
      # - **monthly**: 168+ days range
      #
      # This affects how the transactions array is grouped and formatted.
      def granularity
        @raw["granularity"]
      end

      # Array of transaction breakdowns grouped by the specified granularity.
      #
      # **Each transaction object contains:**
      #
      # - `total_amount`: Total amount for the period in smallest currency unit
      # - `total_count`: Number of transactions for the period
      # - `period_start`: Start of the period (format varies by granularity)
      #
      # **Period start formats:**
      #
      # - **hourly**: "HH:00:00" (e.g., "14:00:00")
      # - **daily**: "YYYY-MM-DD" ISO 8601 format (e.g., "2024-01-15")
      # - **weekly**: "YYYY-MM-DD" (week start date)
      # - **monthly**: "YYYY-MM-DD" (month start date)
      #
      # **Note:** Array may be empty if no transactions exist for the specified date range.
      def transactions
        @raw["transactions"]
      end

    end

    class RetrieveMerchantSettingsResult
      def initialize(raw)
        @raw = raw
      end

      # The preferred language for communication (e.g., 'en', 'th').
      def preferred_communication_language
        @raw["preferred_communication_language"]
      end

      # Whether contact payouts require authorization by a second user before processing.
      def payout_contact_authorization_required
        @raw["payout_contact_authorization_required"]
      end

      # Whether the user who requested the payout is allowed to authorize it themselves.
      def payout_allow_self_authorization
        @raw["payout_allow_self_authorization"]
      end

      # Whether payouts created via merchant API keys bypass the authorization requirement.
      def payout_skip_authorization_for_api_key
        @raw["payout_skip_authorization_for_api_key"]
      end

    end

    class RetrieveMonthlyBillingArchiveResult
      def initialize(raw)
        @raw = raw
      end

      # The identifying month and year of the billing archive in 'YYYY-MM' format.
      def id
        @raw["id"]
      end

      # The download URL where the archive can be downloaded.
      def url
        @raw["url"]
      end

    end

    class KeyPersonAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the key person.
      def key_person_id
        @raw["key_person_id"]
      end

      # The full name of the key person.
      def full_name
        @raw["full_name"]
      end

      # The first name of the key person.
      def first_name
        @raw["first_name"]
      end

      # The middle name of the key person.
      def middle_name
        @raw["middle_name"]
      end

      # The last name of the key person.
      def last_name
        @raw["last_name"]
      end

      # The first name in the local language.
      def first_name_local_language
        @raw["first_name_local_language"]
      end

      # The middle name in the local language.
      def middle_name_local_language
        @raw["middle_name_local_language"]
      end

      # The last name in the local language.
      def last_name_local_language
        @raw["last_name_local_language"]
      end

      # The date of birth in ISO 8601 format.
      def date_of_birth
        @raw["date_of_birth"]
      end

      # The nationality of the key person.
      def nationality
        @raw["nationality"]
      end

      # The type of key person (e.g., 'UBO', 'AUTHORIZED_SIGNATORY').
      def type
        @raw["type"]
      end

      # The percentage of ownership in the business.
      def percentage_of_ownership
        @raw["percentage_of_ownership"]
      end

      # Whether the key person is an authorized director.
      def authorized_director
        @raw["authorized_director"]
      end

      # The national ID number of the key person.
      def national_id
        @raw["national_id"]
      end

      # The expiry date of the national ID in ISO 8601 format.
      def national_id_expiry_date
        @raw["national_id_expiry_date"]
      end

      # Whether the national ID has a lifetime validity.
      def national_id_without_expiry_date
        @raw["national_id_without_expiry_date"]
      end

      # The passport number of the key person.
      def passport_number
        @raw["passport_number"]
      end

      # The expiry date of the passport in ISO 8601 format.
      def passport_expiry_date
        @raw["passport_expiry_date"]
      end

      # The street of the key person's residence registration address.
      def address_street_1
        @raw["address_street_1"]
      end

      # The street of the key person's residence registration address (line 2).
      def address_street_2
        @raw["address_street_2"]
      end

      # The postal code of the key person's residence registration address.
      def postal_code
        @raw["postal_code"]
      end

      # The city of the key person's residence registration address.
      def city
        @raw["city"]
      end

      # State, province, or major administrative region of the key person's residence registration address.
      def primary_administrative_division
        @raw["primary_administrative_division"]
      end

      # Country of the key person's residence registration address as a 2-letter ISO3661 country code.
      def country
        @raw["country"]
      end

      # The street of the key person's current address.
      def current_address_street_1
        @raw["current_address_street_1"]
      end

      # The street of the key person's current address (line 2).
      def current_address_street_2
        @raw["current_address_street_2"]
      end

      # The postal code of the key person's current address.
      def current_address_postal_code
        @raw["current_address_postal_code"]
      end

      # The city of the key person's current address.
      def current_address_city
        @raw["current_address_city"]
      end

      # The primary administrative division (state/province) of the key person's current address.
      def current_address_primary_administrative_division
        @raw["current_address_primary_administrative_division"]
      end

      # The country of the key person's current address as a 2-letter ISO3661 country code.
      def current_address_country
        @raw["current_address_country"]
      end

      # If true, the residence registration address is used as the current address.
      def use_residence_registration_as_current_address
        @raw["use_residence_registration_as_current_address"]
      end

    end

    class UploadAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the uploaded file.
      def upload_id
        @raw["upload_id"]
      end

      # The original filename of the uploaded file.
      def filename
        @raw["filename"]
      end

      # The size of the file in bytes.
      def file_size
        @raw["file_size"]
      end

      # The MIME type of the uploaded file.
      def file_type
        @raw["file_type"]
      end

      # The download URL for the uploaded file.
      def url
        @raw["url"]
      end

    end

    class RequiredDocumentAttributes
      def initialize(raw)
        @raw = raw
      end

      # The label identifying the required document.
      def label
        @raw["label"]
      end

      # Whether multiple files can be uploaded for this document requirement.
      def allow_multiple
        @raw["allow_multiple"]
      end

      # The confirmed files uploaded for this document requirement.
      def uploaded_documents
        (@raw["uploaded_documents"] || []).map { |item| UploadAttributes.new(item) }
      end

    end

    class SalesChannelAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the sales channel.
      def sales_channel_id
        @raw["sales_channel_id"]
      end

      # The platform type of the sales channel (e.g., `WEB`, `IOS`, `ANDROID`, `TERMINAL`).
      def platform
        @raw["platform"]
      end

      # The URL of the sales channel.
      def url
        @raw["url"]
      end

      # The demo URL for testing the sales channel integration.
      def demo_url
        @raw["demo_url"]
      end

      # Instructions for setting up the sales channel integration.
      def instructions
        @raw["instructions"]
      end

    end

    class OnboardingAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the onboarding process.
      def onboarding_id
        @raw["onboarding_id"]
      end

      # The ID of the test merchant.
      def test_merchant_id
        @raw["test_merchant_id"]
      end

      # The ID of the live merchant, if available.
      def live_merchant_id
        @raw["live_merchant_id"]
      end

      # The current status of the onboarding process (e.g., `DRAFT`, `SUBMITTED`, `APPROVED`).
      def status
        @raw["status"]
      end

      # The readiness checklist showing completion status of required fields.
      def readiness
        @raw["readiness"]
      end

      # The type of entity being onboarded (e.g., `INDIVIDUAL`, `BUSINESS`).
      def entity_type
        @raw["entity_type"]
      end

      # The display name of the merchant.
      def merchant_display_name
        @raw["merchant_display_name"]
      end

      # The legal name of the merchant entity.
      def legal_name
        @raw["legal_name"]
      end

      # The merchant category code (MCC) for the business.
      def category_code
        @raw["category_code"]
      end

      # List of product types the merchant will offer.
      def product_types
        @raw["product_types"]
      end

      # Business entity details (only present for business entities).
      def business
        @raw["business"]
      end

      # Individual entity details (only present for individual entities).
      def individual
        @raw["individual"]
      end

      # List of key people associated with the business (only for business entities).
      def key_people
        (@raw["key_people"] || []).map { |item| KeyPersonAttributes.new(item) }
      end

      # The primary bank account for payouts.
      def primary_bank_account
        @raw["primary_bank_account"]
      end

      # The frequency of automatic payouts (e.g., `DAILY`, `WEEKLY`, `NEVER`).
      def auto_payout_frequency
        @raw["auto_payout_frequency"]
      end

      # The total transaction amount the merchant expects to process each month, in subunits (e.g. `100000` for 1,000.00 THB). Returns `0` when not declared yet.
      def expected_monthly_transaction_amount
        @raw["expected_monthly_transaction_amount"]
      end

      # The largest amount the merchant expects for a single transaction, in subunits (e.g. `50000` for 500.00 THB). Returns `0` when not declared yet.
      def expected_maximum_transaction_amount
        @raw["expected_maximum_transaction_amount"]
      end

      # List of required documents and their upload status.
      def required_documents
        (@raw["required_documents"] || []).map { |item| RequiredDocumentAttributes.new(item) }
      end

      # List of sales channels configured for the merchant.
      def sales_channels
        (@raw["sales_channels"] || []).map { |item| SalesChannelAttributes.new(item) }
      end

      # The preferred language for communication (e.g., 'en', 'th').
      def preferred_communication_language
        @raw["preferred_communication_language"]
      end

      # The reason for the requested changes.
      def requested_changes_reason
        @raw["requested_changes_reason"]
      end

      # The reason for the rejection, if applicable.
      def rejection_reason
        @raw["rejection_reason"]
      end

    end

    class RetrievePrimaryBankAccountResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the bank account.
      def bank_account_id
        @raw["bank_account_id"]
      end

      # The bank code identifying the financial institution.
      def bank_code
        @raw["bank_code"]
      end

      # The bank account number.
      def number
        @raw["number"]
      end

      # The name of the account holder.
      def name
        @raw["name"]
      end

      # The ISO country code where the bank account is located.
      def country_code
        @raw["country_code"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was created.
      def created_at
        @raw["created_at"]
      end

      # The Unix timestamp (seconds since epoch) when the bank account was deleted.
      def deleted_at
        @raw["deleted_at"]
      end

      # Whether the bank account can be deleted. A bank account is deletable if it is not the primary bank account, or if it is the primary bank account but it is the only bank account for the contact.
      def deletable
        @raw["deletable"]
      end

      # Whether this bank account belongs to a contact or the merchant.
      def owner
        @raw["owner"]
      end

      # Whether this is the primary bank account for its owner (the contact or the merchant).
      def primary
        @raw["primary"]
      end

    end

    class RetrieveRefundPerformanceResult
      def initialize(raw)
        @raw = raw
      end

      # The start date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the beginning of the date range for which performance data is calculated.
      # For single day requests, this will be the same as end_date.
      def start_date
        @raw["start_date"]
      end

      # The end date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the end of the date range for which performance data is calculated.
      # For single day requests, this will be the same as start_date.
      def end_date
        @raw["end_date"]
      end

      # The total amount of all captured transactions in the period, expressed in the smallest currency unit. E.g. 100 THB is represented as 10000. And 100 JPY is represented as 100.
      def amount
        @raw["amount"]
      end

      # The total number of captured transactions in the period.
      def count
        @raw["count"]
      end

      # The average captured transaction amount in the smallest currency unit.
      def average
        @raw["average"]
      end

      # The percentage change in total amount compared to the previous equivalent period.
      #
      # **Values:**
      #
      # - **Positive**: Indicates an increase in compared to the previous period
      # - **Negative**: Indicates a decrease in compared to the previous period
      # - **Null**: When there are no transactions in the previous period (division by zero)
      #
      # **Example:** A value of 15.5 means increased by 15.5% compared to the previous period.
      def change
        @raw["change"]
      end

      # The time granularity used for transaction breakdown in the response.
      #
      # **Granularity is determined by the date range:**
      #
      # - **hourly**: Single day requests (0 days)
      # - **daily**: 1-83 days range
      # - **weekly**: 84-167 days range
      # - **monthly**: 168+ days range
      #
      # This affects how the transactions array is grouped and formatted.
      def granularity
        @raw["granularity"]
      end

      # Array of transaction breakdowns grouped by the specified granularity.
      #
      # **Each transaction object contains:**
      #
      # - `total_amount`: Total amount for the period in smallest currency unit
      # - `total_count`: Number of transactions for the period
      # - `period_start`: Start of the period (format varies by granularity)
      #
      # **Period start formats:**
      #
      # - **hourly**: "HH:00:00" (e.g., "14:00:00")
      # - **daily**: "YYYY-MM-DD" ISO 8601 format (e.g., "2024-01-15")
      # - **weekly**: "YYYY-MM-DD" (week start date)
      # - **monthly**: "YYYY-MM-DD" (month start date)
      #
      # **Note:** Array may be empty if no transactions exist for the specified date range.
      def transactions
        @raw["transactions"]
      end

    end

    class RetrieveSalesPerformanceResult
      def initialize(raw)
        @raw = raw
      end

      # The start date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the beginning of the date range for which performance data is calculated.
      # For single day requests, this will be the same as end_date.
      def start_date
        @raw["start_date"]
      end

      # The end date of the performance period in ISO 8601 format (YYYY-MM-DD).
      #
      # This represents the end of the date range for which performance data is calculated.
      # For single day requests, this will be the same as start_date.
      def end_date
        @raw["end_date"]
      end

      # The total amount of all captured transactions in the period, expressed in the smallest currency unit. E.g. 100 THB is represented as 10000. And 100 JPY is represented as 100.
      def amount
        @raw["amount"]
      end

      # The total number of captured transactions in the period.
      def count
        @raw["count"]
      end

      # The average captured transaction amount in the smallest currency unit.
      def average
        @raw["average"]
      end

      # The percentage change in total amount compared to the previous equivalent period.
      #
      # **Values:**
      #
      # - **Positive**: Indicates an increase in compared to the previous period
      # - **Negative**: Indicates a decrease in compared to the previous period
      # - **Null**: When there are no transactions in the previous period (division by zero)
      #
      # **Example:** A value of 15.5 means increased by 15.5% compared to the previous period.
      def change
        @raw["change"]
      end

      # The time granularity used for transaction breakdown in the response.
      #
      # **Granularity is determined by the date range:**
      #
      # - **hourly**: Single day requests (0 days)
      # - **daily**: 1-83 days range
      # - **weekly**: 84-167 days range
      # - **monthly**: 168+ days range
      #
      # This affects how the transactions array is grouped and formatted.
      def granularity
        @raw["granularity"]
      end

      # Array of transaction breakdowns grouped by the specified granularity.
      #
      # **Each transaction object contains:**
      #
      # - `total_amount`: Total amount for the period in smallest currency unit
      # - `total_count`: Number of transactions for the period
      # - `period_start`: Start of the period (format varies by granularity)
      #
      # **Period start formats:**
      #
      # - **hourly**: "HH:00:00" (e.g., "14:00:00")
      # - **daily**: "YYYY-MM-DD" ISO 8601 format (e.g., "2024-01-15")
      # - **weekly**: "YYYY-MM-DD" (week start date)
      # - **monthly**: "YYYY-MM-DD" (month start date)
      #
      # **Note:** Array may be empty if no transactions exist for the specified date range.
      def transactions
        @raw["transactions"]
      end

    end

    class SendPaymentLinkResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the queued communication delivery.
      def communication_delivery_id
        @raw["communication_delivery_id"]
      end

      # The communication channel used for this delivery.
      def communication_channel_id
        @raw["communication_channel_id"]
      end

      # The payment link sent to the recipient.
      def payment_link_id
        @raw["payment_link_id"]
      end

      # How the message is delivered.
      def delivery
        @raw["delivery"]
      end

      # The email address or mobile number.
      def recipient
        @raw["recipient"]
      end

      # The contact matched by the recipient. Null when no contact matches.
      def contact_id
        @raw["contact_id"]
      end

      # The current delivery status. Accepted means the provider accepted the message.
      def status
        @raw["status"]
      end

      # When the delivery was queued.
      def created_at
        @raw["created_at"]
      end

      # When the provider accepted the message.
      def accepted_at
        @raw["accepted_at"]
      end

    end

    class StartCheckoutResult
      def initialize(raw)
        @raw = raw
      end

      # The unique identifier for the checkout
      def checkout_id
        @raw["checkout_id"]
      end

      # The payment amount in the smallest currency unit (e.g. cents).
      def amount
        @raw["amount"]
      end

      # The currency code for the payment amount
      def currency
        @raw["currency"]
      end

      # The checkout-specific installment interest bearer override. Null means the merchant's configured default is used.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The unique identifier of the merchant installation associated with this checkout
      def installation_id
        @raw["installation_id"]
      end

      # The unique identifier of the customer making the payment
      def customer_id
        @raw["customer_id"]
      end

      # The email address of the customer
      def customer_email
        @raw["customer_email"]
      end

      # The mobile phone number of the customer
      def customer_mobile
        @raw["customer_mobile"]
      end

      # The name of the customer
      def customer_name
        @raw["customer_name"]
      end

      # The merchant's internal reference for this checkout. Copied onto the payment when the customer pays.
      def external_id
        @raw["external_id"]
      end

      # The URL where the customer will be redirected to make payment
      def redirect_url
        @raw["redirect_url"]
      end

      # The unique identifier of the payment associated with this checkout. When nil, the payment has not been paid yet.
      def payment_id
        @raw["payment_id"]
      end

    end

    class SupportedPaymentMethodsResult
      def initialize(raw)
        @raw = raw
      end

      # The name of the payment method.
      def name
        @raw["name"]
      end

      # The display name of the payment method.
      def display_name
        @raw["display_name"]
      end

      # The flow of the payment method.
      def flow
        @raw["flow"]
      end

      # The category of the payment method.
      def category
        @raw["category"]
      end

      # The platforms on which the payment method is available.
      def platforms
        @raw["platforms"]
      end

    end

    class ValidateBankAccountResult
      def initialize(raw)
        @raw = raw
      end

      # Whether the bank confirmed that the bank account exists.
      def available
        @raw["available"]
      end

      # Whether `score` is greater than or equal to the given `sensitivity`.
      def match
        @raw["match"]
      end

      # How closely the given name matches the account holder name, from 0 (no match) to 1 (exact match).
      def score
        @raw["score"]
      end

      # How similar the characters of the given name are to the account holder name, from 0 to 1.
      def similarity
        @raw["similarity"]
      end

      # The number of characters that differ between the given name and the account holder name. Null when the bank account is not available.
      def distance
        @raw["distance"]
      end

      # The given name as it was compared with the account holder name. Null when the bank account is not available.
      def normalized_name
        @raw["normalized_name"]
      end

    end

    # Sentinel distinguishing "caller omitted this optional argument" from
    # "caller explicitly passed nil" - forwarding nil either way would send
    # the real client (and the real server) an explicit JSON null for an
    # argument that was never actually given.
    Undefined = ::Object.new.freeze

    class Client
      # The package endpoint this client was generated from.
      SOURCE_URL = "https://api.reservepay.com/merchants"

      # Pass a real ::WebFunction::Client to wrap it (handy in tests), or pass nothing
      # to connect to SOURCE_URL, the endpoint this file was generated from.
      def initialize(real_client = nil, bearer_auth: nil, version: nil, pipelined: false)
        if real_client
          if bearer_auth || version || pipelined
            raise ::ArgumentError, "bearer_auth, version and pipelined apply only when no real_client is given"
          end

          @real_client = real_client
        else
          @real_client = ::WebFunction::Client.from_package_endpoint(SOURCE_URL, bearer_auth: bearer_auth, version: version, pipelined: pipelined)
        end
      end

      # @param url [String]
      def self.from_package_endpoint(url, bearer_auth: nil, version: nil, pipelined: false)
        new(::WebFunction::Client.from_package_endpoint(url, bearer_auth: bearer_auth, version: version, pipelined: pipelined))
      end

      # ## Abort a payment on a terminal
      #
      # This endpoint cancels any payment request that was sent to a terminal via start-payment-on-terminal.
      # This only works if the payment was not yet started.
      #
      # It returns true if successful.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The terminal could not be found.
      def abort_payment_on_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        @real_client.abort_payment_on_terminal(**args)
      end

      # ## Add contact
      #
      # Adds a new contact for the merchant. Either `contact_email` or `contact_mobile` must be provided.
      # The service will check for existing contacts with the same ID, email, or mobile number
      # and raise a conflict error if any duplicates are found.
      # May raise WebFunction::BadRequestError with code CONFLICT - A contact with the same ID, email, or mobile number already exists. Each contact must have unique values for these fields.
      # May raise WebFunction::BadRequestError with code VALIDATION_ERROR - Validation failed. Either `contact_email` or `contact_mobile` must be provided. If `contact_email` is provided, it must be a valid email format.
      def add_contact(external_id: Undefined, contact_email: Undefined, contact_mobile: Undefined, contact_name: Undefined, favorite: Undefined)
        args = {}
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:contact_email] = contact_email unless contact_email.equal?(Undefined)
        args[:contact_mobile] = contact_mobile unless contact_mobile.equal?(Undefined)
        args[:contact_name] = contact_name unless contact_name.equal?(Undefined)
        args[:favorite] = favorite unless favorite.equal?(Undefined)
        @real_client.add_contact(**args)
      end

      # ## Add a key person
      #
      # Add a key person to your business merchant account. Key people are individuals
      # who have significant control or influence over your business, such as:
      #
      # - Ultimate Beneficial Owners (UBOs) who own 25% or more of the business
      # - Authorized Signatories who can legally represent and make decisions for
      #   the business
      #
      # This endpoint is only available for business merchants, not
      # individual merchants.
      #
      # You'll need to provide basic information about the person as well as their
      # identification documents:
      #
      # - For local nationals (nationality matches merchant's country): National ID
      #   details are required
      # - For foreign nationals: Passport details are required
      #
      # The endpoint returns a unique identifier for the key person that can be used to
      # reference them in other API calls.
      # May raise WebFunction::BadRequestError with code NOT_BUSINESS - This error occurs when attempting to add a key person to an individual merchant account. Key persons can only be added to business merchant accounts. If you need to upgrade to a business account, please contact support.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def add_key_person(first_name:, middle_name: Undefined, last_name:, first_name_local_language: Undefined, middle_name_local_language: Undefined, last_name_local_language: Undefined, date_of_birth:, nationality:, type:, percentage_of_ownership: Undefined, authorized_director: Undefined, national_id: Undefined, national_id_expiry_date: Undefined, national_id_without_expiry_date: Undefined, passport_number: Undefined, passport_expiry_date: Undefined, address_street_1: Undefined, address_street_2: Undefined, postal_code: Undefined, city: Undefined, primary_administrative_division: Undefined, country: Undefined, current_address_street_1: Undefined, current_address_street_2: Undefined, current_address_postal_code: Undefined, current_address_city: Undefined, current_address_primary_administrative_division: Undefined, current_address_country: Undefined, use_residence_registration_as_current_address: Undefined)
        args = {}
        args[:first_name] = first_name
        args[:middle_name] = middle_name unless middle_name.equal?(Undefined)
        args[:last_name] = last_name
        args[:first_name_local_language] = first_name_local_language unless first_name_local_language.equal?(Undefined)
        args[:middle_name_local_language] = middle_name_local_language unless middle_name_local_language.equal?(Undefined)
        args[:last_name_local_language] = last_name_local_language unless last_name_local_language.equal?(Undefined)
        args[:date_of_birth] = date_of_birth
        args[:nationality] = nationality
        args[:type] = type
        args[:percentage_of_ownership] = percentage_of_ownership unless percentage_of_ownership.equal?(Undefined)
        args[:authorized_director] = authorized_director unless authorized_director.equal?(Undefined)
        args[:national_id] = national_id unless national_id.equal?(Undefined)
        args[:national_id_expiry_date] = national_id_expiry_date unless national_id_expiry_date.equal?(Undefined)
        args[:national_id_without_expiry_date] = national_id_without_expiry_date unless national_id_without_expiry_date.equal?(Undefined)
        args[:passport_number] = passport_number unless passport_number.equal?(Undefined)
        args[:passport_expiry_date] = passport_expiry_date unless passport_expiry_date.equal?(Undefined)
        args[:address_street_1] = address_street_1 unless address_street_1.equal?(Undefined)
        args[:address_street_2] = address_street_2 unless address_street_2.equal?(Undefined)
        args[:postal_code] = postal_code unless postal_code.equal?(Undefined)
        args[:city] = city unless city.equal?(Undefined)
        args[:primary_administrative_division] = primary_administrative_division unless primary_administrative_division.equal?(Undefined)
        args[:country] = country unless country.equal?(Undefined)
        args[:current_address_street_1] = current_address_street_1 unless current_address_street_1.equal?(Undefined)
        args[:current_address_street_2] = current_address_street_2 unless current_address_street_2.equal?(Undefined)
        args[:current_address_postal_code] = current_address_postal_code unless current_address_postal_code.equal?(Undefined)
        args[:current_address_city] = current_address_city unless current_address_city.equal?(Undefined)
        args[:current_address_primary_administrative_division] = current_address_primary_administrative_division unless current_address_primary_administrative_division.equal?(Undefined)
        args[:current_address_country] = current_address_country unless current_address_country.equal?(Undefined)
        args[:use_residence_registration_as_current_address] = use_residence_registration_as_current_address unless use_residence_registration_as_current_address.equal?(Undefined)
        @real_client.add_key_person(**args)
      end

      # ## Add a payment link
      #
      # Create a new payment link that can be shared with customers to collect payments.
      # A payment link is a unique URL that redirects customers to a hosted checkout page.
      #
      # If no `installation_*` attributes are provided, the merchant's default link installation will be used.
      # If any `installation_*` attributes (like `installation_email_capture`) are provided,
      # a new one-off installation will be created for this payment link,
      # based on the merchant's default link installation attributes and the provided attributes.
      def add_payment_link(amount:, currency:, interest_bearer: Undefined, description:, external_id: Undefined, expires_at: Undefined, single_use: Undefined, capture: Undefined, send_confirmation_email: Undefined, installation_name: Undefined, installation_payment_methods: Undefined, installation_email_capture: Undefined, installation_mobile_capture: Undefined, installation_address_capture: Undefined)
        args = {}
        args[:amount] = amount
        args[:currency] = currency
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        args[:description] = description
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:expires_at] = expires_at unless expires_at.equal?(Undefined)
        args[:single_use] = single_use unless single_use.equal?(Undefined)
        args[:capture] = capture unless capture.equal?(Undefined)
        args[:send_confirmation_email] = send_confirmation_email unless send_confirmation_email.equal?(Undefined)
        args[:installation_name] = installation_name unless installation_name.equal?(Undefined)
        args[:installation_payment_methods] = installation_payment_methods unless installation_payment_methods.equal?(Undefined)
        args[:installation_email_capture] = installation_email_capture unless installation_email_capture.equal?(Undefined)
        args[:installation_mobile_capture] = installation_mobile_capture unless installation_mobile_capture.equal?(Undefined)
        args[:installation_address_capture] = installation_address_capture unless installation_address_capture.equal?(Undefined)
        (v = @real_client.add_payment_link(**args)) && AddPaymentLinkResult.new(v)
      end

      # ## Add a Sales Channel
      #
      # Add a new sales channel for the merchant.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def add_sales_channel(platform:, url: Undefined, demo_url: Undefined, instructions: Undefined)
        args = {}
        args[:platform] = platform
        args[:url] = url unless url.equal?(Undefined)
        args[:demo_url] = demo_url unless demo_url.equal?(Undefined)
        args[:instructions] = instructions unless instructions.equal?(Undefined)
        @real_client.add_sales_channel(**args)
      end

      # ## Add a new terminal
      #
      # Creates a new terminal under the authenticated merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The installation_id or delegated_terminal_id does not exist in this merchant account.
      # May raise WebFunction::BadRequestError with code INVALID_ARGUMENT - The delegated terminal already has a delegation configured, it is already used by another terminal, or kiosk_mode cannot be combined with delegated_terminal_id.
      def add_terminal(name:, external_id: Undefined, installation_id: Undefined, branch_name: Undefined, kiosk_mode: Undefined, delegated_terminal_id: Undefined)
        args = {}
        args[:name] = name
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:installation_id] = installation_id unless installation_id.equal?(Undefined)
        args[:branch_name] = branch_name unless branch_name.equal?(Undefined)
        args[:kiosk_mode] = kiosk_mode unless kiosk_mode.equal?(Undefined)
        args[:delegated_terminal_id] = delegated_terminal_id unless delegated_terminal_id.equal?(Undefined)
        @real_client.add_terminal(**args)
      end

      # ## Add to metadata set
      #
      # Adds an item to a metadata set. A metadata set is an array of unique values within your metadata. This endpoint ensures
      # that the metadata at the given path is treated as a set:
      # - If the path is empty or does not exist, it is initialized as an empty array.
      # - If the value already exists in the set, it is not added again.
      # - The metadata at the path must be an array (or empty).
      #
      # #### Example
      # If current metadata is `{"tags": ["a"]}`, adding `"b"` to path `"tags"` results in `{"tags": ["a", "b"]}`.
      # Adding `"a"` again results in no change.
      #
      # #### Expiration (TTL)
      # Adding to a set also updates the `expires_at` timestamp for the entire metadata record.
      def add_to_metadata_set(key:, path: Undefined, value:, version: Undefined, ttl: Undefined)
        args = {}
        args[:key] = key
        args[:path] = path unless path.equal?(Undefined)
        args[:value] = value
        args[:version] = version unless version.equal?(Undefined)
        args[:ttl] = ttl unless ttl.equal?(Undefined)
        @real_client.add_to_metadata_set(**args)
      end

      # ## Add a topup
      #
      # Add funds to your test merchant balance. This simulates an incoming bank
      # transfer settling into your account, letting you build up a balance so you can
      # exercise other endpoints such as sending payouts.
      #
      # Optionally supply a `virtual_account_number` to simulate the transfer
      # arriving into one of your virtual accounts.
      #
      # This endpoint is only available to test merchant accounts. Live merchants are
      # funded through real bank transfers and cannot top up their balance through the
      # API.
      #
      # The topup settles immediately, so the funds are available in your balance as
      # soon as this call returns.
      # May raise WebFunction::BadRequestError with code NOT_ALLOWED - Topups can only be added to test merchant accounts. This error occurs when the authenticated merchant is a live account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when a `virtual_account_number` is supplied but no virtual account with that number exists in your merchant account.
      def add_topup(amount:, virtual_account_number: Undefined, transaction_id: Undefined, sender_account_name: Undefined, sender_account_number: Undefined, sender_bank_code: Undefined)
        args = {}
        args[:amount] = amount
        args[:virtual_account_number] = virtual_account_number unless virtual_account_number.equal?(Undefined)
        args[:transaction_id] = transaction_id unless transaction_id.equal?(Undefined)
        args[:sender_account_name] = sender_account_name unless sender_account_name.equal?(Undefined)
        args[:sender_account_number] = sender_account_number unless sender_account_number.equal?(Undefined)
        args[:sender_bank_code] = sender_bank_code unless sender_bank_code.equal?(Undefined)
        @real_client.add_topup(**args)
      end

      # ## Assign a role to a user in the merchant account
      #
      # This endpoint allows you to assign an existing role to a user within your merchant account.
      def assign_role(user_id:, role_id: Undefined)
        args = {}
        args[:user_id] = user_id
        args[:role_id] = role_id unless role_id.equal?(Undefined)
        @real_client.assign_role(**args)
      end

      # ## List available API versions
      #
      # Get a list of all API versions available that are currently enabled for your merchant account.
      #
      # The endpoint returns an array of API versions that you can use in other endpoints.
      def available_api_versions
        @real_client.available_api_versions
      end

      # ## Balance history
      #
      # Returns a paginated list of **ledger entries** for the merchant's default balance, newest first.
      # Each row includes the owning **transaction** (`transaction_id`) alongside the entry fields.
      # There is **no time window**: all entries for the balance are included, ordered by recency.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the balance history.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No balance exists for this merchant.
      def balance_history(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.balance_history(**args), EntryAttributes)
      end

      # ## Cancel payment
      #
      # Cancels a payment that should not go through. The customer is not charged for a cancelled payment.
      #
      # Payments in a `PENDING` status, payments in an `AUTHORIZED` status whose authorization has not
      # expired yet, and payments in a `SUCCESSFUL` status that have not been settled yet, can be
      # cancelled. Cancelling an `AUTHORIZED` payment releases the hold on the customer's funds. Once a
      # payment is cancelled, its status changes to `CANCELLED`.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      # May raise WebFunction::BadRequestError with code NOT_CANCELLABLE - Payment is not eligible for cancellation. This can happen if the payment is not in a `PENDING`, `AUTHORIZED` or `SUCCESSFUL` status, its authorization has expired, it has already been settled, or its payment method does not support cancellations.
      def cancel_payment(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        @real_client.cancel_payment(**args)
      end

      # ## Capture payment
      #
      # Captures a previously authorized payment. Capture is the second step of a two-step payment flow
      # (authorize and capture). This endpoint should be called when you are ready to complete the
      # transaction and receive funds, such as when shipping goods or providing a service.
      #
      # Only payments that are in an `AUTHORIZED` status can be captured. Once a payment is captured,
      # its status changes to `SUCCESSFUL` (or `FAILED` if the capture fails).
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      # May raise WebFunction::BadRequestError with code NOT_CAPTURABLE - Payment is not eligible for capture. This can happen if the payment is not in an authorized state, the capture window has passed, or the integration does not support captures.
      def capture_payment(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        @real_client.capture_payment(**args)
      end

      # ## Challenge dispute
      #
      # Confirms the submission of evidence and formally challenges the dispute.
      #
      # A non-refundable challenge fee is charged to the merchant's balance via the daily statement upon
      # submission. This fee is waived if the original payment was protected by 3D Secure. Failure to
      # challenge the dispute within the deadline results in an automatic loss in favor of the customer.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute was not found.
      # May raise WebFunction::BadRequestError with code INVALID_TRANSITION - The dispute is not in a state that can be challenged (e.g., already won or lost).
      # May raise WebFunction::BadRequestError with code MISSING_EVIDENCE - No evidence has been uploaded for this dispute action.
      def challenge_dispute(dispute_id:)
        args = {}
        args[:dispute_id] = dispute_id
        @real_client.challenge_dispute(**args)
      end

      # ## Clone a payment link
      #
      # Create a new payment link based on an existing one.
      # The new link will have the same amount, currency, description, and other settings.
      # May raise WebFunction::BadRequestError with code not_found - The original payment link could not be found.
      def clone_payment_link(payment_link_id:, external_id: Undefined)
        args = {}
        args[:payment_link_id] = payment_link_id
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        (v = @real_client.clone_payment_link(**args)) && ClonePaymentLinkResult.new(v)
      end

      # ## Concede dispute
      #
      # Concedes the dispute and accepts the loss. This action is irreversible. The disputed funds are
      # permanently deducted from the merchant's balance.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute was not found.
      # May raise WebFunction::BadRequestError with code INVALID_TRANSITION - The dispute is not in a state that can be conceded (e.g., already won or lost).
      def concede_dispute(dispute_id:)
        args = {}
        args[:dispute_id] = dispute_id
        @real_client.concede_dispute(**args)
      end

      # ## Confirm branding upload
      #
      # Confirms the upload of a branding asset by providing the `upload_id`. This effectively attaches
      # the uploaded file to the merchant branding.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no upload with the provided ID exists in your merchant account.
      def confirm_branding_upload(upload_id:)
        args = {}
        args[:upload_id] = upload_id
        @real_client.confirm_branding_upload(**args)
      end

      # ## Confirm dispute evidence upload
      #
      # Confirms the upload of an evidence file for a dispute by providing the `upload_id`.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute or upload was not found.
      # May raise WebFunction::BadRequestError with code not_uploadable - The dispute is not in a state that allows evidence upload.
      def confirm_dispute_evidence_upload(dispute_id:, upload_id:)
        args = {}
        args[:dispute_id] = dispute_id
        args[:upload_id] = upload_id
        @real_client.confirm_dispute_evidence_upload(**args)
      end

      # ## Confirm Onboarding Upload
      #
      # Confirms the upload of an onboarding document by providing the `upload_id`.
      #
      # This effectively attaches the uploaded file to the relevant merchant, business, individual or key person.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no upload with the provided ID exists in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def confirm_onboarding_upload(upload_id:)
        args = {}
        args[:upload_id] = upload_id
        @real_client.confirm_onboarding_upload(**args)
      end

      # ## Disable an SDK installation
      #
      # Temporarily disable an SDK installation. This will prevent the installation from
      # being able to make API calls like tokenizing cards or creating payments.
      #
      # Common reasons to disable an installation:
      #
      # - You're decommissioning an old version of your application
      # - You want to temporarily stop accepting payments on a specific platform
      # - You suspect unauthorized or malicious use from a specific installation
      # - You're performing maintenance or updates on your application
      #
      # You can re-enable a disabled installation at any time using the
      # `enable-installation` endpoint.
      #
      # Note that disabling an installation only affects its ability to make API calls -
      # it does not delete the installation or any of its settings. The installation ID
      # remains valid and can be used again once re-enabled.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no installation with the provided ID exists in your merchant account.
      def disable_installation(installation_id:)
        args = {}
        args[:installation_id] = installation_id
        @real_client.disable_installation(**args)
      end

      # ## Disable a payment link
      #
      # Disables a payment link so it can no longer be used to collect payments.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment link with the provided ID exists in your merchant account. Double check that you're using the correct payment link ID.
      def disable_payment_link(payment_link_id:)
        args = {}
        args[:payment_link_id] = payment_link_id
        @real_client.disable_payment_link(**args)
      end

      # ## Disable a terminal
      #
      # Temporarily disable a terminal. This does not delete the terminal.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      def disable_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        @real_client.disable_terminal(**args)
      end

      # ## Disconnect webhook
      #
      # Disconnects an existing webhook endpoint. Once disconnected, the endpoint will no longer receive
      # any event notifications.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when the webhook endpoint with the provided ID could not be found.
      def disconnect_webhook(webhook_id:)
        args = {}
        args[:webhook_id] = webhook_id
        @real_client.disconnect_webhook(**args)
      end

      # ## Enable an SDK installation
      #
      # Re-enable a previously disabled SDK installation. Once enabled, the installation
      # can resume making API calls like tokenizing cards or creating payments.
      #
      # Common reasons to re-enable an installation:
      #
      # - You've completed maintenance or updates on your application
      # - You're ready to resume accepting payments on a specific platform
      # - You've resolved any security concerns about unauthorized usage
      # - You're bringing a previously decommissioned application back online
      #
      # Note that enabling an installation takes effect immediately and restores the
      # exact same configuration and settings from before it was disabled. This also
      # does not require any changes to your integration code and can be reversed at any
      # time by using the `disable-installation` endpoint.
      #
      # For security best practices, we recommend only enabling installations that are
      # actively being used.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no installation with the provided ID exists in your merchant account. Double check that you're using the correct installation ID.
      def enable_installation(installation_id:)
        args = {}
        args[:installation_id] = installation_id
        @real_client.enable_installation(**args)
      end

      # ## Enable a payment link
      #
      # Enables a previously disabled payment link so it can be used to collect payments again.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment link with the provided ID exists in your merchant account. Double check that you're using the correct payment link ID.
      def enable_payment_link(payment_link_id:)
        args = {}
        args[:payment_link_id] = payment_link_id
        @real_client.enable_payment_link(**args)
      end

      # ## Enable a terminal
      #
      # Re-enable a previously disabled terminal.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      def enable_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        @real_client.enable_terminal(**args)
      end

      # ## Escalate dispute
      #
      # Requests a final review of the dispute by the bank.
      #
      # An escalation hold is applied to the merchant's balance to help cover the potential escalation fee.
      # This hold is released once the dispute is resolved, regardless of the outcome. If the dispute is lost, a separate
      # escalation fee is charged to the merchant's balance via the daily statement. The hold and
      # fee are independent and their amounts may differ; refer to the dispute escalation
      # documentation for specific fee schedules by region and provider.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute was not found.
      # May raise WebFunction::BadRequestError with code INVALID_TRANSITION - The dispute is not in a state that can be escalated.
      def escalate_dispute(dispute_id:)
        args = {}
        args[:dispute_id] = dispute_id
        @real_client.escalate_dispute(**args)
      end

      # ## Filter contacts
      #
      # Returns a paginated list of contacts for the authenticated merchant with filtering capabilities.
      #
      # Filter by name, email, mobile (substring match) and creation date. Free-text `terms` also matches
      # contact ID and external ID. Results are ordered by creation date descending.
      def filter_contacts(per_page: Undefined, page: Undefined, name: Undefined, email: Undefined, mobile: Undefined, terms: Undefined, created_at: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:name] = name unless name.equal?(Undefined)
        args[:email] = email unless email.equal?(Undefined)
        args[:mobile] = mobile unless mobile.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        TypedPage.new(@real_client.filter_contacts(**args), ContactAttributes)
      end

      # ## Filter payment links
      #
      # Returns a paginated list of payment links for the authenticated merchant with advanced filtering capabilities.
      #
      # This endpoint provides comprehensive search functionality using database-driven filtering,
      # allowing you to filter links by status, usage, batch, amount ranges, and date ranges.
      #
      # The response includes pagination controls with `previous` and `next` cursors that can be used
      # to navigate through the payment link history efficiently.
      #
      # ### Features:
      # - **Full-text search**: Search across payment link descriptions and UIDs
      # - **Advanced filtering**: Filter by status (active, disabled, expired, paid), usage (single, multiple), and batch ID
      # - **Range support**: Support for amount ranges and date ranges
      def filter_payment_links(per_page: Undefined, page: Undefined, terms: Undefined, status: Undefined, usage: Undefined, batch_id: Undefined, amount: Undefined, created_at: Undefined, expires_at: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        args[:status] = status unless status.equal?(Undefined)
        args[:usage] = usage unless usage.equal?(Undefined)
        args[:batch_id] = batch_id unless batch_id.equal?(Undefined)
        args[:amount] = amount unless amount.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:expires_at] = expires_at unless expires_at.equal?(Undefined)
        TypedPage.new(@real_client.filter_payment_links(**args), PaymentLinkAttributes)
      end

      # ## Filter payments
      #
      # Returns a paginated list of payments for the authenticated merchant with advanced filtering capabilities.
      #
      # This endpoint provides comprehensive search functionality using the SearchIndex infrastructure,
      # allowing you to filter payments by various criteria including status, payment method, payment method category,
      # installment issuer, currency, amount ranges, terminal, and date ranges.
      #
      # The response includes pagination controls with `previous` and `next` cursors that can be used
      # to navigate through the payment history efficiently.
      #
      # ### Features:
      # - **Full-text search**: Search across payment content
      # - **Advanced filtering**: Filter by status, payment method, payment method category, installment issuer, currency, amount, contact, terminal, dates, and fraud finding
      # - **Contact filtering**: Filter by contact internal ID or external ID
      # - **Date range support**: Support for specific dates, datetimes, date ranges, datetime ranges, and keywords
      # - **Pagination**: Efficient cursor-based pagination
      # - **Merchant-scoped**: Only returns payments for the authenticated merchant
      def filter_payments(per_page: Undefined, page: Undefined, status: Undefined, created_at: Undefined, authorized_at: Undefined, captured_at: Undefined, payment_method: Undefined, payment_method_category: Undefined, issuer_id: Undefined, currency: Undefined, amount: Undefined, contact_id: Undefined, terminal_id: Undefined, terms: Undefined, fraud_finding: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:status] = status unless status.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:authorized_at] = authorized_at unless authorized_at.equal?(Undefined)
        args[:captured_at] = captured_at unless captured_at.equal?(Undefined)
        args[:payment_method] = payment_method unless payment_method.equal?(Undefined)
        args[:payment_method_category] = payment_method_category unless payment_method_category.equal?(Undefined)
        args[:issuer_id] = issuer_id unless issuer_id.equal?(Undefined)
        args[:currency] = currency unless currency.equal?(Undefined)
        args[:amount] = amount unless amount.equal?(Undefined)
        args[:contact_id] = contact_id unless contact_id.equal?(Undefined)
        args[:terminal_id] = terminal_id unless terminal_id.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        args[:fraud_finding] = fraud_finding unless fraud_finding.equal?(Undefined)
        TypedPage.new(@real_client.filter_payments(**args), PaymentAttributes)
      end

      # ## Filter Payouts
      #
      # Returns a paginated list of payouts for the authenticated merchant with advanced filtering capabilities.
      #
      # This endpoint provides comprehensive search functionality using the SearchIndex infrastructure,
      # allowing you to filter payouts by various criteria including status, payout method, currency,
      # batch, amount ranges, and date ranges.
      #
      # The response includes pagination controls with `previous` and `next` cursors that can be used
      # to navigate through the payout history efficiently.
      #
      # ### Features:
      # - **Full-text search**: Search across payout content
      # - **Advanced filtering**: Filter by status, payout method, currency, batch, amount, and dates
      # - **Date range support**: Support for specific dates, datetimes, date ranges, datetime ranges, and keywords
      # - **Pagination**: Efficient cursor-based pagination
      # - **Merchant-scoped**: Only returns payouts for the authenticated merchant
      def filter_payouts(per_page: Undefined, page: Undefined, status: Undefined, created_at: Undefined, paid_at: Undefined, sent_at: Undefined, payout_method: Undefined, currency: Undefined, amount: Undefined, bank_code: Undefined, contact_id: Undefined, batch_id: Undefined, terms: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:status] = status unless status.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:paid_at] = paid_at unless paid_at.equal?(Undefined)
        args[:sent_at] = sent_at unless sent_at.equal?(Undefined)
        args[:payout_method] = payout_method unless payout_method.equal?(Undefined)
        args[:currency] = currency unless currency.equal?(Undefined)
        args[:amount] = amount unless amount.equal?(Undefined)
        args[:bank_code] = bank_code unless bank_code.equal?(Undefined)
        args[:contact_id] = contact_id unless contact_id.equal?(Undefined)
        args[:batch_id] = batch_id unless batch_id.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        TypedPage.new(@real_client.filter_payouts(**args), PayoutAttributes)
      end

      # ## Filter terminals
      #
      # Returns a paginated list of terminals for the authenticated merchant with filtering capabilities.
      #
      # Filter by terminal name, branch name (substring match), creation date, and connection date. Free-text
      # `terms` matches terminal name, terminal ID, external ID, and branch name. Results are ordered by creation date descending.
      def filter_terminals(per_page: Undefined, page: Undefined, name: Undefined, branch_name: Undefined, terms: Undefined, created_at: Undefined, connected_at: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:name] = name unless name.equal?(Undefined)
        args[:branch_name] = branch_name unless branch_name.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:connected_at] = connected_at unless connected_at.equal?(Undefined)
        TypedPage.new(@real_client.filter_terminals(**args), TerminalAttributes)
      end

      # ## Filter topups
      #
      # Returns a paginated list of topups for the authenticated merchant with advanced filtering capabilities.
      #
      # This endpoint provides comprehensive search functionality using the SearchIndex infrastructure,
      # allowing you to filter topups by funding type (manual or virtual account), virtual account number,
      # amount ranges, and date ranges.
      #
      # The response includes pagination controls with `previous` and `next` cursors that can be used
      # to navigate through the topup history efficiently.
      #
      # ### Features:
      # - **Funding type**: Filter by manual transfers or virtual account topups
      # - **Virtual account**: Filter by the virtual account number that received the funds
      # - **Amount ranges**: Filter by an exact amount or a range
      # - **Date range support**: Support for specific dates, datetimes, date ranges, datetime ranges, and keywords
      # - **Pagination**: Efficient cursor-based pagination
      # - **Merchant-scoped**: Only returns topups for the authenticated merchant
      def filter_topups(per_page: Undefined, page: Undefined, type: Undefined, virtual_account_number: Undefined, amount: Undefined, created_at: Undefined, terms: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:page] = page unless page.equal?(Undefined)
        args[:type] = type unless type.equal?(Undefined)
        args[:virtual_account_number] = virtual_account_number unless virtual_account_number.equal?(Undefined)
        args[:amount] = amount unless amount.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        TypedPage.new(@real_client.filter_topups(**args), TopupAttributes)
      end

      # ## Find bank account
      #
      # Retrieves details about a specific bank account. The `bank_account_id` can be either the internal
      # UID (starting with 'bka_') or your own external ID.
      #
      # This endpoint returns both active and soft-deleted bank accounts from the merchant's directory.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No bank account found with the provided bank_account_id in this merchant's directory. The bank account may not exist or may not belong to the merchant's directory.
      def find_bank_account(bank_account_id:)
        args = {}
        args[:bank_account_id] = bank_account_id
        (v = @real_client.find_bank_account(**args)) && FindBankAccountResult.new(v)
      end

      # ## Find batch
      #
      # Retrieve a batch by ID, including its current status, any prepare or processing error,
      # the preview download URL when prepare has completed, and the result download URL when
      # processing has completed. `awaiting_authorization` is true when any payout in the batch is still requested.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The batch was not found.
      def find_batch(batch_id:)
        args = {}
        args[:batch_id] = batch_id
        (v = @real_client.find_batch(**args)) && FindBatchResult.new(v)
      end

      # ## Find card
      #
      # Find a card by its ID or token. Either card_id or token must be provided.
      #
      # The card_id can be either the internal UID (starting with 'crd_') or your own external ID.
      #
      # The token can be either the token UID (starting with 'tkn_') or the raw card number associated with the token.
      #
      # This endpoint returns both active and soft-deleted cards from the merchant's directory.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No card found with the provided card_id or token in this merchant's directory. The card may not exist or may not belong to the merchant's directory.
      def find_card(card_id: Undefined, token: Undefined)
        args = {}
        args[:card_id] = card_id unless card_id.equal?(Undefined)
        args[:token] = token unless token.equal?(Undefined)
        (v = @real_client.find_card(**args)) && FindCardResult.new(v)
      end

      # ## Find a communication delivery
      #
      # Retrieves a communication delivery queued by send-payment-link, including its latest status.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The communication delivery does not exist for this merchant.
      def find_communication_delivery(communication_delivery_id:)
        args = {}
        args[:communication_delivery_id] = communication_delivery_id
        (v = @real_client.find_communication_delivery(**args)) && FindCommunicationDeliveryResult.new(v)
      end

      # ## Find dispute
      #
      # Returns the details of a specific dispute.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute was not found.
      def find_dispute(dispute_id:)
        args = {}
        args[:dispute_id] = dispute_id
        (v = @real_client.find_dispute(**args)) && FindDisputeResult.new(v)
      end

      # ## Find an SDK installation
      #
      # Retrieve details about a specific SDK installation in your merchant account.
      # This endpoint returns information about the installation's:
      #
      # - Name and platform (web, iOS, Android or Terminal)
      # - Unique identifier (domain, bundle ID or package name)
      # - Enabled payment methods
      # - Current status (enabled or disabled)
      #
      # The installation ID required by this endpoint is the same ID that was returned
      # when you created the installation using the add-installation endpoint.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no installation with the provided ID exists in your merchant account. Double check that you're using the correct installation ID.
      def find_installation(installation_id:)
        args = {}
        args[:installation_id] = installation_id
        (v = @real_client.find_installation(**args)) && FindInstallationResult.new(v)
      end

      # ## Find an invoice
      #
      # Retrieve details about a specific invoice in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no invoice with the provided ID exists in your merchant account. Double check that you're using the correct invoice ID.
      def find_invoice(invoice_id:)
        args = {}
        args[:invoice_id] = invoice_id
        (v = @real_client.find_invoice(**args)) && FindInvoiceResult.new(v)
      end

      # ## Find an API key
      #
      # Retrieve details about a specific API key in your merchant account. This
      # endpoint returns information about the key's:
      #
      # - Name and description
      # - Current status (enabled or disabled)
      #
      # The key ID required by this endpoint is the same ID that was returned when you created
      # the key using the `generate-key` endpoint.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no API key with the provided ID exists in your merchant account. Double check that you're using the correct key ID.
      def find_key(key_id:)
        args = {}
        args[:key_id] = key_id
        (v = @real_client.find_key(**args)) && FindKeyResult.new(v)
      end

      # ## Find a payment
      #
      # Retrieve details about a specific payment by its unique identifier or external ID.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      def find_payment(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        (v = @real_client.find_payment(**args)) && FindPaymentResult.new(v)
      end

      # ## Find a payment link
      #
      # Retrieve details about a specific payment link in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment link with the provided ID exists in your merchant account. Double check that you're using the correct payment link ID.
      def find_payment_link(payment_link_id:)
        args = {}
        args[:payment_link_id] = payment_link_id
        (v = @real_client.find_payment_link(**args)) && FindPaymentLinkResult.new(v)
      end

      # ## Find a payout
      #
      # Retrieves a specific payout by its unique identifier or external ID.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payout with the provided ID exists in your merchant account. Double check that you're using the correct payout ID.
      def find_payout(payout_id:)
        args = {}
        args[:payout_id] = payout_id
        (v = @real_client.find_payout(**args)) && FindPayoutResult.new(v)
      end

      # ## Find a refund
      #
      # Retrieves a specific refund by its unique identifier or external ID.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no refund with the provided ID exists in your merchant account. Double check that you're using the correct refund ID.
      def find_refund(refund_id:)
        args = {}
        args[:refund_id] = refund_id
        (v = @real_client.find_refund(**args)) && FindRefundResult.new(v)
      end

      # ## Find a terminal
      #
      # Find a terminal by ID and return its details.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      def find_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        (v = @real_client.find_terminal(**args)) && FindTerminalResult.new(v)
      end

      # ## Find a topup
      #
      # Retrieve details about a specific balance top-up in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no topup with the provided ID exists in your merchant account. Double check that you're using the correct topup ID.
      def find_topup(topup_id:)
        args = {}
        args[:topup_id] = topup_id
        (v = @real_client.find_topup(**args)) && FindTopupResult.new(v)
      end

      # ## Find a virtual account
      #
      # Retrieves a specific virtual account by its unique identifier.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no virtual account with the provided ID exists in your merchant account. Double check that you're using the correct virtual account ID.
      def find_virtual_account(virtual_account_id:)
        args = {}
        args[:virtual_account_id] = virtual_account_id
        (v = @real_client.find_virtual_account(**args)) && FindVirtualAccountResult.new(v)
      end

      # ## Find a webhook
      #
      # Retrieves details about a specific webhook in merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no webhook with the provided ID exists in your merchant account. Double check that you're using the correct webhook ID.
      def find_webhook(webhook_id:)
        args = {}
        args[:webhook_id] = webhook_id
        (v = @real_client.find_webhook(**args)) && FindWebhookResult.new(v)
      end

      # ## Forget card
      #
      # Forget (soft delete) a card from a contact. The card will be marked as deleted but the record will be preserved for audit purposes.
      #
      # Cards include a `deletable` attribute that indicates whether the card can be deleted. The frontend should check this attribute before attempting to delete a card. If a card cannot be deleted, set another card as the default using the `set-default-card` endpoint, which will update the `deletable` attribute accordingly.
      #
      # The endpoint returns `true` when the card is successfully forgotten.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id, or the card with the provided card_id does not exist or does not belong to the contact.
      # May raise WebFunction::BadRequestError with code INVALID_OPERATION - Cannot delete primary card when contact has multiple cards. Set another card as primary first.
      def forget_card(contact_id:, card_id:)
        args = {}
        args[:contact_id] = contact_id
        args[:card_id] = card_id
        @real_client.forget_card(**args)
      end

      # ## Generate branding upload URL
      #
      # Generates a pre-signed URL for uploading branding assets (logos, sidebar images) to the merchant's
      # storage. Returns an object containing the URL and the object key (which includes the timestamped filename).
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when the merchant branding is not found.
      def generate_branding_upload_url(filename:, type:, md5_hash:, byte_size:)
        args = {}
        args[:filename] = filename
        args[:type] = type
        args[:md5_hash] = md5_hash
        args[:byte_size] = byte_size
        (v = @real_client.generate_branding_upload_url(**args)) && GenerateBrandingUploadUrlResult.new(v)
      end

      # ## Generate dispute evidence upload URL
      #
      # Generates a pre-signed URL for uploading evidence for a dispute. Returns an object containing
      # the URL and the object key.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified dispute was not found.
      # May raise WebFunction::BadRequestError with code INVALID_STATE - The dispute is not in a state that allows evidence upload.
      def generate_dispute_evidence_upload_url(dispute_id:, filename:, md5_hash:, byte_size:, comment: Undefined)
        args = {}
        args[:dispute_id] = dispute_id
        args[:filename] = filename
        args[:md5_hash] = md5_hash
        args[:byte_size] = byte_size
        args[:comment] = comment unless comment.equal?(Undefined)
        (v = @real_client.generate_dispute_evidence_upload_url(**args)) && GenerateDisputeEvidenceUploadUrlResult.new(v)
      end

      # ## Generate Onboarding Upload URL
      # Generates a pre-signed URL for uploading onboarding documents to the merchant's storage.
      # Returns an object containing the URL and the object key (which includes the timestamped filename).
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def generate_onboarding_upload_url(filename:, type:, md5_hash:, byte_size:)
        args = {}
        args[:filename] = filename
        args[:type] = type
        args[:md5_hash] = md5_hash
        args[:byte_size] = byte_size
        (v = @real_client.generate_onboarding_upload_url(**args)) && GenerateOnboardingUploadUrlResult.new(v)
      end

      # ## Generate a temporary terminal challenge
      #
      # Generate a unique 8-digit challenge for a terminal that is not connected and is enabled.
      # The challenge expires 5 minutes after it is issued. Calling this again before
      # expiry returns the same challenge.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - The terminal exists but is disabled.
      # May raise WebFunction::BadRequestError with code ALREADY_CONNECTED - The terminal is already connected to a device.
      def generate_temporary_terminal_challenge(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        (v = @real_client.generate_temporary_terminal_challenge(**args)) && GenerateTemporaryTerminalChallengeResult.new(v)
      end

      # ## Get merchant balance
      #
      # Returns the current balance information for the authenticated merchant.
      #
      # The response includes the current balance amount and currency.
      def get_balance
        (v = @real_client.get_balance) && GetBalanceResult.new(v)
      end

      # ## Initiate the payment flow
      #
      # Start a new payment flow using a payment session from our SDK. This endpoint
      # creates a payment and returns a unique payment ID that you can use to track
      # its status.
      #
      # The payment flow typically involves:
      #
      # 1. Your customer selecting a payment method in the SDK
      # 2. You initiating the payment with the session ID from step 1
      # 3. The customer completing the payment via their selected payment method
      # 4. Our system notifying you of the final payment status via webhook, or you
      #    polling the status of the payment
      #
      # The payment ID returned by this endpoint can be used to track the payment status
      # and details.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The payment session ID provided doesn't match any active session in our system, or the card_id doesn't match any card belonging to the customer. This usually means the session has expired or was already used, or the card has been deleted. The customer should select their payment method again in the SDK to generate a new session.
      # May raise WebFunction::BadRequestError with code CONFLICT - The payment session amount and currency do not match the amount and currency provided in the request. The payment session was created with specific values that must match when initiating the payment flow. Ensure the amount and currency in your request match the values used when creating the payment session. The payment external_id must also be unique within the merchant account.
      # May raise WebFunction::BadRequestError with code NOT_SUPPORTED - The payment method selected does not support the requested operation. This occurs when capture is set to false but the payment method's integrations do not support authorization without capture. Choose a different payment method or set capture to true.
      # May raise WebFunction::BadRequestError with code CUSTOMER_REQUIRED - A customer identifier is required when the payment session uses a saved card token. Provide customer_id, customer_email, or customer_mobile to identify the card's owner.
      # May raise WebFunction::BadRequestError with code CUSTOMER_MISMATCH - The customer identifier provided does not match the saved card on the payment session. When the session was created with a saved card token, the customer_id or customer_email must belong to the card's owner.
      def initiate_payment_flow(external_id: Undefined, amount:, currency:, payment_session_id:, card_id: Undefined, capture:, return_url:, customer_id: Undefined, customer_email: Undefined, customer_mobile: Undefined, customer_name: Undefined, save_card: Undefined, interest_bearer: Undefined)
        args = {}
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:amount] = amount
        args[:currency] = currency
        args[:payment_session_id] = payment_session_id
        args[:card_id] = card_id unless card_id.equal?(Undefined)
        args[:capture] = capture
        args[:return_url] = return_url
        args[:customer_id] = customer_id unless customer_id.equal?(Undefined)
        args[:customer_email] = customer_email unless customer_email.equal?(Undefined)
        args[:customer_mobile] = customer_mobile unless customer_mobile.equal?(Undefined)
        args[:customer_name] = customer_name unless customer_name.equal?(Undefined)
        args[:save_card] = save_card unless save_card.equal?(Undefined)
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        @real_client.initiate_payment_flow(**args)
      end

      # ## Link bank account to a contact
      #
      # Link a bank account to a contact. This creates a new bank account record associated with the contact.
      #
      # - The bank account is added to the contact's list of bank accounts
      # - If the contact has no bank account, this new account will automatically become the primary one
      # - If the `primary` parameter is set to `true`, this account will be set as the primary bank account (replacing any existing primary account)
      # - If the contact already has a primary bank account and `primary` is not set, this new account will be added as a secondary account
      #
      # The endpoint returns a unique identifier for the bank account that you can use to reference it in other API calls.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id.
      # May raise WebFunction::BadRequestError with code COUNTRY_MISMATCH - The bank account's country code does not match your payment provider's country.
      # May raise WebFunction::BadRequestError with code INVALID_BANK_CODE - The bank code is not valid for Thailand. Bank codes must be 3-digit codes assigned by the Bank of Thailand.
      def link_bank_account(contact_id:, bank_code:, number:, name:, country_code:, primary: Undefined, external_id: Undefined)
        args = {}
        args[:contact_id] = contact_id
        args[:bank_code] = bank_code
        args[:number] = number
        args[:name] = name
        args[:country_code] = country_code
        args[:primary] = primary unless primary.equal?(Undefined)
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        @real_client.link_bank_account(**args)
      end

      # ## List activity logs
      #
      # Returns a paginated list of merchant-scoped activity for supported transaction,
      # billing, and team events. Each row includes actor information, the parent resource,
      # and optional plan or refund identifiers.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the activity history.
      #
      # Use the search arguments to narrow results by activity type, actor, object,
      # parent resource, or creation date.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The actor_email or actor_key_id does not belong to this merchant.
      def list_activity_logs(per_page: Undefined, after: Undefined, before: Undefined, activity_type: Undefined, actor_email: Undefined, actor_key_id: Undefined, object_id: Undefined, parent_id: Undefined, created_at: Undefined, terms: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        args[:activity_type] = activity_type unless activity_type.equal?(Undefined)
        args[:actor_email] = actor_email unless actor_email.equal?(Undefined)
        args[:actor_key_id] = actor_key_id unless actor_key_id.equal?(Undefined)
        args[:object_id] = object_id unless object_id.equal?(Undefined)
        args[:parent_id] = parent_id unless parent_id.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        TypedPage.new(@real_client.list_activity_logs(**args), ActivityLogAttributes)
      end

      # ## List API request logs
      #
      # Returns a paginated list of HTTP requests recorded for this live merchant.
      # Each row includes the endpoint, HTTP status, client IP address, request source,
      # dashboard user email when applicable, and client or browser identification.
      # May raise WebFunction::BadRequestError with code FORBIDDEN - API request logs are only available for live merchants.
      def list_api_request_logs(per_page: Undefined, after: Undefined, before: Undefined, status: Undefined, source: Undefined, endpoint: Undefined, user_email: Undefined, ip_address: Undefined, created_at: Undefined, terms: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        args[:status] = status unless status.equal?(Undefined)
        args[:source] = source unless source.equal?(Undefined)
        args[:endpoint] = endpoint unless endpoint.equal?(Undefined)
        args[:user_email] = user_email unless user_email.equal?(Undefined)
        args[:ip_address] = ip_address unless ip_address.equal?(Undefined)
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:terms] = terms unless terms.equal?(Undefined)
        TypedPage.new(@real_client.list_api_request_logs(**args), ApiRequestLogAttributes)
      end

      # ## List batches
      #
      # Returns a paginated list of batches for the authenticated merchant, newest first.
      # A caller only receives batch types their permissions allow.
      # `awaiting_authorization` is true when any payout in the batch is still requested.
      #
      # Optionally filter by `type` to return only batches of that kind (for example `PAYMENT_LINK`).
      def list_batches(type: Undefined, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:type] = type unless type.equal?(Undefined)
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_batches(**args), BatchAttributes)
      end

      # ## List communication channels
      #
      # Returns the communication channels configured for this merchant.
      #
      # This endpoint requires authentication.
      def list_communication_channels
        (@real_client.list_communication_channels || []).map { |item| CommunicationChannelAttributes.new(item) }
      end

      # ## List contacts
      #
      # Returns a paginated list of all contacts for the authenticated merchant.
      def list_contacts(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_contacts(**args), ContactAttributes)
      end

      # ## List disputes
      #
      # Returns a paginated list of all disputes for the authenticated merchant.
      # Responds with a cursor-paginated page object containing `page`, `next`, and `previous` cursors.
      def list_disputes(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_disputes(**args), DisputeAttributes)
      end

      # ## List disputes by payment
      #
      # Returns a paginated list of disputes for a specific payment.
      #
      # The `payment_id` is the payment UID (for example `pay_...`).
      #
      # The response uses cursor-based pagination with `previous` and `next` cursors.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No payment found with the provided payment_id for this merchant.
      def list_disputes_by_payment(payment_id:, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:payment_id] = payment_id
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_disputes_by_payment(**args), DisputeAttributes)
      end

      # ## List email subscribers
      #
      # Retrieve all email subscription objects for this merchant. Each object contains the email address,
      # language, and all subscribed notification topics for that email.
      #
      # This endpoint requires authentication and will return an array of email subscription objects,
      # where each object represents one email address with all its notification topic subscriptions.
      def list_email_subscribers
        (@real_client.list_email_subscribers || []).map { |item| EmailRecipientAttributes.new(item) }
      end

      # ## List all SDK installations
      #
      # Retrieve a list of all SDK installations in your merchant account. This endpoint returns an array of
      # installation objects, each containing details about:
      #
      # - Name and platform (web, iOS, Android or Terminal)
      # - Unique identifier (domain, bundle ID or package name)
      # - Enabled payment methods
      # - Current status (enabled or disabled)
      #
      # See `find-installation` for the complete list of response attributes.
      #
      # Common use cases for this endpoint:
      #
      # - Auditing which installations are currently active
      # - Checking the configuration of multiple installations
      # - Finding installations that need to be updated or disabled
      # - Getting an overview of your integration across different platforms
      def list_installations
        (@real_client.list_installations || []).map { |item| InstallationAttributes.new(item) }
      end

      # ## List installment issuers
      #
      # Returns the card issuers the authenticated merchant can take installment payments with, sorted by display name.
      #
      # Use an issuer's `issuer_id` with `filter-payments` to list the payments made with cards from that issuer.
      #
      # Returns an empty array when the merchant does not offer installments.
      def list_installment_issuers
        (@real_client.list_installment_issuers || []).map { |item| ListInstallmentIssuersResult.new(item) }
      end

      # ## List invoices
      #
      # Returns a paginated list of invoices for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the invoice history.
      def list_invoices(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_invoices(**args), InvoiceAttributes)
      end

      # ## List all API keys
      #
      # Retrieve a list of all API keys associated with your merchant account. This endpoint returns an array of
      # key objects containing details about each key, including:
      #
      # - Key name and ID
      # - Creation time
      # - Current status (enabled or disabled)
      #
      # See `generate-key` or `find-key` for the complete list of response attributes.
      #
      # Common use cases for this endpoint:
      #
      # - Auditing active API keys
      # - Identifying unused or outdated keys that should be rotated
      #
      # Note: For security reasons, this endpoint only returns metadata about your keys - it never returns the
      # actual key values. Make sure to securely store your key values when they are first generated, as they
      # cannot be retrieved later.
      def list_keys
        (@real_client.list_keys || []).map { |item| KeyAttributes.new(item) }
      end

      # ## List metadata
      #
      # Returns a paginated list of all metadata records stored for your merchant account.
      def list_metadata(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_metadata(**args), MetadataAttributes)
      end

      # ## List monthly billing archives
      #
      # Returns a paginated list of monthly billing archives for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payment history.
      def list_monthly_billing_archives(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_monthly_billing_archives(**args), MonthlyBillingArchiveAttributes)
      end

      # ## List payment activities
      #
      # Retrieves all activities, events, and payment session information for a given payment.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      def list_payment_activities(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        (@real_client.list_payment_activities(**args) || []).map { |item| PaymentActivityAttributes.new(item) }
      end

      # ## List payments for a payment link
      #
      # Returns a paginated list of payments associated with a specific payment link.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment link with the provided ID exists in your merchant account.
      def list_payment_link_payments(payment_link_id:, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:payment_link_id] = payment_link_id
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payment_link_payments(**args), PaymentAttributes)
      end

      # ## List payment links
      #
      # Returns a paginated list of payment links for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payment link history.
      def list_payment_links(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payment_links(**args), PaymentLinkAttributes)
      end

      # ## List payments
      #
      # Returns a paginated list of payments for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payment history.
      def list_payments(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payments(**args), PaymentAttributes)
      end

      # ## List payments by contact
      #
      # Returns a paginated list of payments for a specific contact belonging to the authenticated merchant.
      #
      # The `contact_id` can be either the internal UID (starting with `ctc_`) or the external ID
      # provided when the contact was created.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payment history for the contact.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id. The contact may not exist or may belong to a different merchant.
      def list_payments_by_contact(contact_id:, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:contact_id] = contact_id
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payments_by_contact(**args), PaymentAttributes)
      end

      # ## List payments by terminal
      #
      # Returns a paginated list of payments for a specific terminal, scoped by each payment's
      # `created_on` date in the merchant's time zone.
      #
      # When `created_at` is omitted, results are limited to payments from the last three months
      # through today (same window as list-payments-by-contact).
      #
      # The `terminal_id` is the terminal UID (for example `trm_...`).
      #
      # The response uses cursor-based pagination with `previous` and `next` cursors.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal found with the provided terminal_id for this merchant.
      def list_payments_by_terminal(terminal_id:, created_at: Undefined, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:terminal_id] = terminal_id
        args[:created_at] = created_at unless created_at.equal?(Undefined)
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payments_by_terminal(**args), PaymentAttributes)
      end

      # ## List payout activities
      #
      # Retrieves all activities, events, and payout session information for a given payout.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payout with the provided ID exists in your merchant account. Double check that you're using the correct payout ID.
      def list_payout_activities(payout_id:)
        args = {}
        args[:payout_id] = payout_id
        (@real_client.list_payout_activities(**args) || []).map { |item| ListPayoutActivitiesResult.new(item) }
      end

      # ## List payouts
      #
      # Returns a paginated list of payouts for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payout history.
      def list_payouts(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payouts(**args), PayoutAttributes)
      end

      # ## List payouts by contact
      #
      # Returns a paginated list of payouts for a specific contact belonging to the authenticated merchant.
      #
      # The `contact_id` can be either the internal UID (starting with `ctc_`) or the external ID
      # provided when the contact was created.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the payout history for the contact.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id. The contact may not exist or may belong to a different merchant.
      def list_payouts_by_contact(contact_id:, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:contact_id] = contact_id
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_payouts_by_contact(**args), PayoutAttributes)
      end

      # ## List all permissions
      #
      # Retrieves a list of all permissions available for roles within the merchant account.
      # These permissions can be assigned to custom roles created by the merchant, and to API keys.
      def list_permissions
        @real_client.list_permissions
      end

      # ## List planned maintenances
      #
      # Retrieve recent and upcoming planned maintenance windows for our services.
      def list_planned_maintenances(language: Undefined)
        args = {}
        args[:language] = language unless language.equal?(Undefined)
        (@real_client.list_planned_maintenances(**args) || []).map { |item| PlannedMaintenanceAttributes.new(item) }
      end

      # ## List all current plans
      # Retrieve a list of all current plans available for the merchant.
      # Plans represent different levels of service or pricing plans currently available.
      # The `selectable` flag indicates if a plan can be subscribed to via self-service.
      #
      # `skus` lists the SKUs the merchant would be billed with on each plan, including the merchant's custom SKUs for the plan's tier.
      def list_plans
        (@real_client.list_plans || []).map { |item| PlanAttributes.new(item) }
      end

      # ## List refunds by payment
      #
      # Returns a paginated list of refunds for a specific payment belonging to the authenticated merchant.
      #
      # The payment_id can be either the internal UID (starting with 'pay_') or the external ID
      # provided when the payment was created.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the refund history for the payment.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No payment found with the provided payment_id.
      def list_refunds_by_payment(payment_id:, per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:payment_id] = payment_id
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_refunds_by_payment(**args), RefundAttributes)
      end

      # ## List all roles
      #
      # Retrieve a list of all roles available in the merchant account.
      # This endpoint returns the roles that can be assigned to users within the merchant account.
      # This includes default roles defined by the system as well as any custom roles created by the merchant.
      def list_roles
        (@real_client.list_roles || []).map { |item| RoleAttributes.new(item) }
      end

      # ## List statements
      #
      # Returns a paginated list of statements for the authenticated merchant grouped by month.
      #
      # The response includes month-based pagination where each page contains all statements
      # for a specific month.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through months.
      # May raise WebFunction::BadRequestError with code invalid_month - Invalid month format. Expected YYYY-MM format (e.g., '2024-12')
      def list_statements(month: Undefined)
        args = {}
        args[:month] = month unless month.equal?(Undefined)
        TypedPage.new(@real_client.list_statements(**args), StatementAttributes)
      end

      # ## List terminals
      #
      # Paginated list of terminals for the merchant.
      def list_terminals(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_terminals(**args), TerminalAttributes)
      end

      # ## List topups
      #
      # Returns a paginated list of balance top-ups for the authenticated merchant.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the topup history.
      def list_topups(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_topups(**args), TopupAttributes)
      end

      # ## List all user invitations
      #
      # Retrieve a list of all email addresses that have been invited to join your merchant account.
      # This endpoints only returns invitations that have not yet been accepted by the invited people.
      def list_user_invitations
        (@real_client.list_user_invitations || []).map { |item| InvitationAttributes.new(item) }
      end

      # ## List all users
      #
      # Retrieve a list of all users who are members of your merchant account.
      # This endpoint returns an array of user objects containing details about each user.
      #
      # Common use cases for this endpoint:
      #
      # - Auditing user access to your merchant account
      # - Identifying users who can perform actions on behalf of the merchant
      # - Managing user permissions and roles within the merchant account
      def list_users
        (@real_client.list_users || []).map { |item| MerchantMembershipAttributes.new(item) }
      end

      # ## List virtual accounts
      #
      # Returns a paginated list of the authenticated merchant's active virtual accounts.
      #
      # The response includes cursor-based pagination with `previous` and `next` cursors
      # that can be used to navigate through the virtual account history.
      def list_virtual_accounts(per_page: Undefined, after: Undefined, before: Undefined)
        args = {}
        args[:per_page] = per_page unless per_page.equal?(Undefined)
        args[:after] = after unless after.equal?(Undefined)
        args[:before] = before unless before.equal?(Undefined)
        TypedPage.new(@real_client.list_virtual_accounts(**args), VirtualAccountAttributes)
      end

      # ## List webhooks
      #
      # Returns an array of all webhook endpoints for the merchant.
      #
      # See `find-webhook` for the complete list of response attributes.
      def list_webhooks
        (@real_client.list_webhooks || []).map { |item| WebhookAttributes.new(item) }
      end

      # ## Pause a webhook endpoint
      #
      # Temporarily disable a webhook connection.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when the webhook endpoint with the provided ID could not be found. Double check that you're using the correct webhook ID.
      def pause_webhook(webhook_id:)
        args = {}
        args[:webhook_id] = webhook_id
        @real_client.pause_webhook(**args)
      end

      # ## Reconfigure SDK installation
      #
      # Modify the configuration of an existing SDK installation in your merchant account. This endpoint allows you to:
      #
      # - Change the installation name
      # - Update which payment methods are enabled
      # - Configure email and mobile capture settings
      #
      # Common use cases for this endpoint:
      #
      # - Rebranding your application with a new name
      # - Adding or removing payment methods as your business needs change
      # - Standardizing installation names across platforms
      # - Adjusting payment method configuration after testing
      # - Updating customer data collection requirements
      #
      # The changes take effect immediately. Any subsequent API calls from this installation will use the new configuration.
      #
      # To see which payment methods are available for your merchant account, use the `supported-payment-methods` endpoint.
      #
      # Note: This endpoint only updates the installation's configuration - it does not affect the installation's enabled/disabled status.
      # Use the dedicated enable/disable endpoints to change an installation's status.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The installation with the provided ID could not be found in your merchant account. Verify that you're using the correct installation ID.
      def reconfigure_installation(installation_id:, name:, payment_methods:, email_capture: Undefined, mobile_capture: Undefined, address_capture: Undefined)
        args = {}
        args[:installation_id] = installation_id
        args[:name] = name
        args[:payment_methods] = payment_methods
        args[:email_capture] = email_capture unless email_capture.equal?(Undefined)
        args[:mobile_capture] = mobile_capture unless mobile_capture.equal?(Undefined)
        args[:address_capture] = address_capture unless address_capture.equal?(Undefined)
        @real_client.reconfigure_installation(**args)
      end

      # ## Reconnect a webhook endpoint
      #
      # Update an existing webhook endpoint connection details.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when the webhook endpoint with the provided ID could not be found.
      def reconnect_webhook(webhook_id:, name:, protocol:, signature_type: Undefined, api_version:, destination_url:, events:)
        args = {}
        args[:webhook_id] = webhook_id
        args[:name] = name
        args[:protocol] = protocol
        args[:signature_type] = signature_type unless signature_type.equal?(Undefined)
        args[:api_version] = api_version
        args[:destination_url] = destination_url
        args[:events] = events
        @real_client.reconnect_webhook(**args)
      end

      # ## Refund a payment
      #
      # Creates a refund for a captured payment that has been billed.
      # Supports partial refunds by specifying an amount less than the
      # remaining refundable amount. Defaults to full refund if amount
      # is not specified.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No payment with the provided ID exists in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_REFUNDABLE - Payment is not eligible for refund. This can happen if the payment has not been billed yet, is already fully refunded, or the integration does not support refunds.
      # May raise WebFunction::BadRequestError with code AMOUNT_EXCEEDS_LIMIT - The refund amount exceeds the remaining refundable amount.
      # May raise WebFunction::BadRequestError with code CONFLICT - A refund with the provided external ID already exists in your merchant account.
      def refund_payment(payment_id:, amount: Undefined, external_id: Undefined)
        args = {}
        args[:payment_id] = payment_id
        args[:amount] = amount unless amount.equal?(Undefined)
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        @real_client.refund_payment(**args)
      end

      # ## Remove branding document
      #
      # Removes a branding asset (logo or sidebar image) that has been uploaded and confirmed. This is
      # useful if you need to replace an asset or if an asset was uploaded in error.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no upload with the provided ID exists in your merchant branding.
      def remove_branding_document(upload_id:)
        args = {}
        args[:upload_id] = upload_id
        @real_client.remove_branding_document(**args)
      end

      # ## Remove contact
      #
      # Removes a contact by its ID. The `contact_id` can be either the internal UID (starting with `ctc_`)
      # or the external ID provided when the contact was created.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id. The contact may not exist or may belong to a different merchant.
      def remove_contact(contact_id:)
        args = {}
        args[:contact_id] = contact_id
        @real_client.remove_contact(**args)
      end

      # ## Remove from metadata set
      #
      # Removes an item from a metadata set. A metadata set is an array of unique values. This endpoint
      # removes a specific value from the set at the given path.
      # - If the value is not found in the set, an error is returned.
      # - The metadata at the path must be an array.
      #
      # #### Example
      # If current metadata is `{"tags": ["a", "b"]}`, removing `"a"` from path `"tags"` results in `{"tags": ["b"]}`.
      # Attempting to remove `"c"` results in an error.
      def remove_from_metadata_set(key:, path: Undefined, value:, version: Undefined)
        args = {}
        args[:key] = key
        args[:path] = path unless path.equal?(Undefined)
        args[:value] = value
        args[:version] = version unless version.equal?(Undefined)
        @real_client.remove_from_metadata_set(**args)
      end

      # ## Remove in metadata
      #
      # Removes a specific nested `path` from a metadata object. This is useful for cleaning up specific
      # parts of a complex metadata structure without overwriting the entire object.
      def remove_in_metadata(key:, path:, version: Undefined)
        args = {}
        args[:key] = key
        args[:path] = path
        args[:version] = version unless version.equal?(Undefined)
        @real_client.remove_in_metadata(**args)
      end

      # ## Remove an SDK installation
      #
      # Permanently delete an SDK installation from your merchant account. This will:
      #
      # - Remove the installation configuration
      # - Invalidate any API calls from this installation
      #
      # Common use cases for this endpoint:
      #
      # - Cleaning up old or unused installations
      # - Decommissioning applications that have been replaced
      #
      # Warning: This action cannot be undone. Once an installation is removed, you'll need to create a new
      # installation if you want to restore access. Consider using the `disable-installation` endpoint instead
      # if you only need to temporarily prevent API access.
      #
      # The endpoint returns true if the installation was successfully removed.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The installation with the provided ID could not be found in your merchant account. Verify that you're using the correct installation ID.
      # May raise WebFunction::BadRequestError with code CANNOT_BE_DELETED - This installation cannot be removed as it is used by Terminals or Payment Links.
      def remove_installation(installation_id:)
        args = {}
        args[:installation_id] = installation_id
        @real_client.remove_installation(**args)
      end

      # ## Remove a key person
      #
      # Permanently remove a key person from your business merchant account during the onboarding phase. This
      # endpoint allows you to remove a key person's details from your business profile while you are still
      # setting up your account.
      #
      # You may need this endpoint if you made a mistake while entering key person details during onboarding,
      # or if there were last-minute changes to your business's ownership structure before completing the
      # registration process.
      #
      # Note that this endpoint only works for merchant accounts that are registered as businesses and only during
      # the initial onboarding phase. Individual merchant accounts cannot use this endpoint, and you cannot
      # remove key persons after completing onboarding.
      #
      # This action cannot be undone. Once a key person is removed, you'll need to add them as a
      # new key person if you want to restore their details.
      #
      # The endpoint returns true if the key person was successfully removed.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The key person with the provided ID could not be found in your merchant account. Verify that you're using the correct key person ID.
      # May raise WebFunction::BadRequestError with code NOT_BUSINESS - This merchant account is not registered as a business. Only business merchant accounts can manage key persons.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def remove_key_person(key_person_id:)
        args = {}
        args[:key_person_id] = key_person_id
        @real_client.remove_key_person(**args)
      end

      # ## Remove an Onboarding Document
      #
      # This endpoint allows you to remove an onboarding document that has been uploaded
      # during the onboarding process. This is useful if you need to replace a document or
      # if a document was uploaded in error.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no upload with the provided ID exists in your merchant account.
      def remove_onboarding_document(upload_id:)
        args = {}
        args[:upload_id] = upload_id
        @real_client.remove_onboarding_document(**args)
      end

      # ## Remove a payment link
      #
      # Soft-delete a payment link. The link is hidden from listings and lookups but the
      # underlying record and any associated payments are preserved for historical and
      # audit purposes.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No payment link with the provided ID exists in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_REMOVABLE - The payment link has one or more associated payments and cannot be removed.
      def remove_payment_link(payment_link_id:)
        args = {}
        args[:payment_link_id] = payment_link_id
        @real_client.remove_payment_link(**args)
      end

      # ## Remove a sales channel
      #
      # Remove a sales channel for the merchant.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no sales channel with the provided ID exists in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def remove_sales_channel(sales_channel_id:)
        args = {}
        args[:sales_channel_id] = sales_channel_id
        @real_client.remove_sales_channel(**args)
      end

      # ## Remove a terminal
      #
      # Remove a terminal from the merchant account by performing a soft delete.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      def remove_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        @real_client.remove_terminal(**args)
      end

      # ## Request a payment
      #
      # Start a card payment directly from your server without requiring customer
      # interaction. This is a merchant-initiated transaction (MIT) endpoint that
      # combines payment method selection and payment initiation into a single call.
      #
      # This endpoint supports card payments only. You can pay using either a saved
      # card ID or a card token from the `tokenize-card` endpoint.
      #
      # Since this is a merchant-initiated transaction, the 3D Secure (3DS)
      # authentication flow is skipped.
      #
      # Your merchant account must have the MIT flag enabled for the card payment
      # method to use this endpoint.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The installation, card, or token could not be found. Double check that you are using the correct IDs and that the card belongs to the specified customer.
      # May raise WebFunction::BadRequestError with code NOT_ALLOWED - Merchant initiated transactions are not allowed for this payment method. Contact support to enable the MIT flag on your card payment method.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - This installation is currently disabled.
      # May raise WebFunction::BadRequestError with code TOKEN_ALREADY_USED - This token has already been used. Request a new token from tokenize-card.
      # May raise WebFunction::BadRequestError with code NOT_SUPPORTED - The payment method does not support the requested operation. This occurs when capture is set to false but the payment method's integrations do not support authorization without capture.
      # May raise WebFunction::BadRequestError with code CONFLICT - A payment with the same external_id already exists in this merchant account.
      def request_payment(card_id: Undefined, token: Undefined, amount:, currency:, installation_id:, capture:, external_id: Undefined, customer_id: Undefined, customer_email: Undefined, customer_mobile: Undefined, customer_name: Undefined, save_card: Undefined)
        args = {}
        args[:card_id] = card_id unless card_id.equal?(Undefined)
        args[:token] = token unless token.equal?(Undefined)
        args[:amount] = amount
        args[:currency] = currency
        args[:installation_id] = installation_id
        args[:capture] = capture
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:customer_id] = customer_id unless customer_id.equal?(Undefined)
        args[:customer_email] = customer_email unless customer_email.equal?(Undefined)
        args[:customer_mobile] = customer_mobile unless customer_mobile.equal?(Undefined)
        args[:customer_name] = customer_name unless customer_name.equal?(Undefined)
        args[:save_card] = save_card unless save_card.equal?(Undefined)
        @real_client.request_payment(**args)
      end

      # ## Reset a terminal
      #
      # Reset the device binding and revoke the current API key for the given terminal.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No terminal exists with the provided ID in this merchant account.
      def reset_terminal(terminal_id:)
        args = {}
        args[:terminal_id] = terminal_id
        @real_client.reset_terminal(**args)
      end

      # ## Resume payment on terminal
      #
      # Sends an in-progress payment to a child (delegated) terminal for display.
      # The parent terminal must have a `delegated_terminal_id` configured.
      #
      # The child terminal will receive a real-time event and navigate to the QR code screen.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The terminal or payment could not be found.
      # May raise WebFunction::BadRequestError with code NO_DELEGATION - The terminal has no delegated terminal configured.
      # May raise WebFunction::BadRequestError with code NO_SESSION - No payment session found for this payment.
      def resume_payment_on_terminal(terminal_id:, payment_id:)
        args = {}
        args[:terminal_id] = terminal_id
        args[:payment_id] = payment_id
        @real_client.resume_payment_on_terminal(**args)
      end

      # ## Resume a webhook endpoint
      #
      # Enable temporarily disabled webhook connection.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when the webhook endpoint with the provided ID could not be found. Double check that you're using the correct webhook ID.
      def resume_webhook(webhook_id:)
        args = {}
        args[:webhook_id] = webhook_id
        @real_client.resume_webhook(**args)
      end

      # ## Retrieve branding
      #
      # Returns the current visual branding settings for your merchant account. This includes colors,
      # typography, button styling, display preferences, and uploaded assets (logos, sidebar images) for
      # your payment interface.
      #
      # The response includes all branding configuration options that can be customized through the
      # `update-branding` endpoint, as well as URLs to any uploaded branding assets.
      #
      # Common use cases for this endpoint include:
      #
      # - Checking your current branding configuration
      # - Previewing how your payment interface will look to customers
      # - Verifying that uploaded logos and images are properly configured
      # - Getting branding settings for integration with your own systems
      #
      # This endpoint requires authentication and will only return branding details for the authenticated merchant.
      def retrieve_branding
        (v = @real_client.retrieve_branding) && RetrieveBrandingResult.new(v)
      end

      # ## Retrieve branding fonts
      #
      # Returns a list of available fonts that can be used for branding your payment interface. This endpoint
      # returns a comprehensive list of fonts that are supported for customizing the typography of your
      # payment forms.
      #
      # The response includes:
      #
      # - Font family names (e.g., 'Noto Sans', 'Roboto')
      # - Font categories (sans-serif, serif, monospace, display, handwriting)
      # - Available font weight variants for each font family
      #
      # Common use cases for this endpoint include:
      #
      # - Populating font selection dropdowns in your branding interface
      # - Validating font choices before updating branding settings
      # - Displaying available font options to users
      # - Building font preview functionality
      #
      # This endpoint requires authentication and returns the same font list for all merchants, as fonts are
      # globally available across the platform.
      #
      # **Note:** Font variants are filtered to exclude italic styles and are converted to readable weight names
      # (e.g., 'Bold', 'Medium', 'Light').
      def retrieve_branding_font
        (@real_client.retrieve_branding_font || []).map { |item| RetrieveBrandingFontResult.new(item) }
      end

      # ## Retrieve checkout
      #
      # Retrieves the details of an existing checkout session. You can use this to check the current
      # status of a checkout, see which payment methods were used, and get customer information.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no checkout with the provided ID exists in your merchant account. Double check that you're using the correct checkout ID.
      def retrieve_checkout(checkout_id:)
        args = {}
        args[:checkout_id] = checkout_id
        (v = @real_client.retrieve_checkout(**args)) && RetrieveCheckoutResult.new(v)
      end

      # ## Retrieve merchant configuration
      #
      # Retrieves the read-only system configuration set up for your merchant account by Reservepay.
      #
      # To view or modify self-service parameters that you control directly, see `retrieve-merchant-settings` and `update-merchant-settings`.
      def retrieve_configuration
        (v = @real_client.retrieve_configuration) && MerchantConfigurationAttributes.new(v)
      end

      # ## Retrieve contact
      #
      # Retrieves a contact by its ID. The `contact_id` can be either the internal UID (starting with `ctc_`)
      # or the external ID provided when the contact was created.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id. The contact may not exist or may belong to a different merchant.
      def retrieve_contact(contact_id:)
        args = {}
        args[:contact_id] = contact_id
        (v = @real_client.retrieve_contact(**args)) && RetrieveContactResult.new(v)
      end

      # ## Retrieve current plan
      #
      # Retrieves the current billing plan for the merchant account.
      # This endpoint returns the plan details including the plan ID, name, tier, and any associated metadata.
      # It is used to check the current subscription status and plan features available to the merchant.
      #
      # The response includes information about the plan's tier, which indicates the level of service provided.
      # It also reports `pending_plan_id`, the plan a scheduled change will promote to, or `null` when no change is scheduled.
      #
      # `skus` lists the SKUs the merchant is billed with, including the merchant's custom SKUs for the plan's tier.
      # May raise WebFunction::BadRequestError with code NO_PLAN_SELECTED - The merchant is not currently subscribed to any plan. A plan must be subscribed to via the `select-plan` endpoint first.
      def retrieve_current_plan
        (v = @real_client.retrieve_current_plan) && CurrentPlanAttributes.new(v)
      end

      # ## Retrieve dispute performance
      #
      # Returns dispute performance data for the authenticated merchant based on the specified date range.
      #
      # The endpoint supports various input formats:
      #
      # - Specific date: `YYYY-MM-DD` (e.g., "2024-01-15")
      # - Date range: `YYYY-MM-DD..YYYY-MM-DD` (e.g., "2024-01-01..2024-01-31")
      #
      # The response includes aggregated metrics such as total amount and count of disputes.
      #
      # ### Timezone Handling
      #
      # The service uses the merchant's configured timezone for all date boundaries and grouping.
      # Disputes are grouped based on the merchant's local date/time.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_FORMAT - Invalid date format. Please use YYYY-MM-DD or YYYY-MM-DD..YYYY-MM-DD.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_RANGE - End date cannot be before start date.
      def retrieve_dispute_performance(period:, include_won: Undefined, include_lost: Undefined, include_in_progress: Undefined)
        args = {}
        args[:period] = period
        args[:include_won] = include_won unless include_won.equal?(Undefined)
        args[:include_lost] = include_lost unless include_lost.equal?(Undefined)
        args[:include_in_progress] = include_in_progress unless include_in_progress.equal?(Undefined)
        (v = @real_client.retrieve_dispute_performance(**args)) && RetrieveDisputePerformanceResult.new(v)
      end

      # ## Retrieve email subscriber
      #
      # Retrieve all notification topic subscriptions for a specific email address within this merchant.
      # Returns a single object with the email, language, and all subscribed notification topics.
      #
      # This endpoint requires authentication and will return subscription details for the specified email.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No subscriber found for the specified email address.
      def retrieve_email_subscriber(email:)
        args = {}
        args[:email] = email
        (v = @real_client.retrieve_email_subscriber(**args)) && EmailRecipientAttributes.new(v)
      end

      # ## Retrieve merchant settings
      #
      # Retrieves current self-service settings for your merchant account. These are values you control directly and can modify using `update-merchant-settings`.
      #
      # To view read-only account settings managed by Reservepay, use `retrieve-configuration`.
      def retrieve_merchant_settings
        (v = @real_client.retrieve_merchant_settings) && RetrieveMerchantSettingsResult.new(v)
      end

      # ## Retrieve metadata
      #
      # Retrieves metadata associated with a specific `key`. You can also specify an optional dot-separated
      # `path` to retrieve only a subset of the metadata.
      #
      # Metadata is a flexible way to store additional information for your account, and can be used for
      # storing configuration, preferences, or any other data you need.
      def retrieve_metadata(key:, path: Undefined, data_only: Undefined)
        args = {}
        args[:key] = key
        args[:path] = path unless path.equal?(Undefined)
        args[:data_only] = data_only unless data_only.equal?(Undefined)
        (v = @real_client.retrieve_metadata(**args)) && MetadataAttributes.new(v)
      end

      # ## Retrieve monthly billing archive
      #
      # Retrieves a monthly billing archive by its ID (i.e., month and year in `YYYY-MM` format).
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No archive found with the provided monthly_billing_archive_id. This could indicate that there was no activity for that month, or that the archive has not yet been created.
      # May raise WebFunction::BadRequestError with code INVALID - The provided monthly_billing_archive_id could not be parsed as a valid month (expected format: 'YYYY-MM').
      def retrieve_monthly_billing_archive(monthly_billing_archive_id:)
        args = {}
        args[:monthly_billing_archive_id] = monthly_billing_archive_id
        (v = @real_client.retrieve_monthly_billing_archive(**args)) && RetrieveMonthlyBillingArchiveResult.new(v)
      end

      # ## Retrieve notification topics
      #
      # Retrieves all available notification topics that merchants can subscribe to. Topics are used to organize
      # different types of notifications such as incidents, payments, developer updates, etc.
      #
      # The response is an array of notification topic objects containing the topic ID, name, and display name.
      #
      # This endpoint requires authentication and returns all available topics that the merchant can potentially
      # subscribe to for email notifications.
      def retrieve_notification_topics
        (@real_client.retrieve_notification_topics || []).map { |item| NotificationTopicAttributes.new(item) }
      end

      # ## Retrieve your onboarding details
      #
      # Get comprehensive details about your onboarding. This includes your onboarding ID, display name, legal name,
      # entity type (business or individual), business category, enabled product types, and auto-payout frequency settings.
      # Your primary bank account information is also returned.
      #
      # For business accounts, this endpoint returns additional information about the business entity and its key people.
      # For individual accounts, it includes the individual's details instead.
      #
      # Common use cases for this endpoint include checking your onboarding status, verifying your business or individual details,
      # and ensuring your primary bank account is set up correctly for payouts.
      #
      # This endpoint requires authentication and will only return details for the authenticated merchant.
      # May raise WebFunction::BadRequestError with code NO_ONBOARDING - This error occurs when the merchant has no onboarding available. Ensure that the merchant has started the onboarding process before attempting to retrieve it.
      def retrieve_onboarding_details
        (v = @real_client.retrieve_onboarding_details) && OnboardingAttributes.new(v)
      end

      # ## Retrieve primary bank account
      #
      # Get the merchant's current primary bank account used for payouts. This is the account configured via `set-primary-bank-account` and used for:
      #
      # - Receiving settlement funds from successful payments
      # - Automated payouts based on your payout schedule
      # - Manual payout requests
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No primary bank account has been configured for this merchant.
      def retrieve_primary_bank_account
        (v = @real_client.retrieve_primary_bank_account) && RetrievePrimaryBankAccountResult.new(v)
      end

      # ## Retrieve refund performance
      #
      # Returns refund performance data for the authenticated merchant based on the specified date range.
      #
      # The endpoint supports various input formats:
      #
      # - Specific date: `YYYY-MM-DD` (e.g., "2024-01-15")
      # - Date range: `YYYY-MM-DD..YYYY-MM-DD` (e.g., "2024-01-01..2024-01-31")
      #
      # The response includes aggregated metrics such as total refunded, transaction count, and average transaction value.
      #
      # - **`exclude_voided`**: The default is `false`, so voided transactions appear alongside your refunds. When `true`, only refund transactions appear.
      #
      # ### Timezone Handling
      #
      # The service uses the merchant's configured timezone for all date boundaries and grouping.
      # Refunds are grouped by `refunded_at` in the merchant's local date/time.
      # For example, a refund at 2025-10-09 22:51:28 UTC would appear in 2025-10-10 data for a merchant in timezone "Asia/Bangkok" (GMT+7).
      #
      # ### Granularity Logic
      #
      # The response granularity is automatically determined based on the date range:
      #
      # - **0 days** (single date): Hourly breakdown
      # - **1-83 days**: Daily breakdown
      # - **84-167 days**: Weekly breakdown
      # - **168+ days**: Monthly breakdown
      #
      # This affects how the `transactions` array is structured and the `granularity` field in the response.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_FORMAT - This error occurs when the date_input parameter is not in a supported format. Please use one of the supported formats: YYYY-MM-DD, YYYY-MM-DD..YYYY-MM-DD, or keywords.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_RANGE - This error occurs when the end date is before the start date in a date range. Please ensure the end date is after or equal to the start date.
      def retrieve_refund_performance(period:, exclude_voided: Undefined)
        args = {}
        args[:period] = period
        args[:exclude_voided] = exclude_voided unless exclude_voided.equal?(Undefined)
        (v = @real_client.retrieve_refund_performance(**args)) && RetrieveRefundPerformanceResult.new(v)
      end

      # ## Retrieve sales performance
      #
      # Returns sales performance data for the authenticated merchant based on the specified date range.
      #
      # The endpoint supports various input formats:
      #
      # - Specific date: `YYYY-MM-DD` (e.g., "2024-01-15")
      # - Date range: `YYYY-MM-DD..YYYY-MM-DD` (e.g., "2024-01-01..2024-01-31")
      #
      # The response includes aggregated metrics such as total sales, transaction count, and average transaction value.
      #
      # - **`exclude_voided`**: The default is `true` — only non-void transactions are counted. When `false`, voided transactions are included in those totals.
      #
      # ### Timezone Handling
      #
      # The service uses the merchant's configured timezone for all date boundaries and grouping.
      # This ensures that payments are grouped according to the merchant's local date/time.
      # For example, a payment at 2025-10-09 22:51:28 UTC would appear in 2025-10-10 data for a merchant in timezone "Asia/Bangkok" (GMT+7).
      #
      # ### Granularity Logic
      #
      # The response granularity is automatically determined based on the date range:
      #
      # - **0 days** (single date): Hourly breakdown
      # - **1-83 days**: Daily breakdown
      # - **84-167 days**: Weekly breakdown
      # - **168+ days**: Monthly breakdown
      #
      # This affects how the `transactions` array is structured and the `granularity` field in the response.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_FORMAT - This error occurs when the date_input parameter is not in a supported format. Please use one of the supported formats: YYYY-MM-DD, YYYY-MM-DD..YYYY-MM-DD, or keywords.
      # May raise WebFunction::BadRequestError with code INVALID_DATE_RANGE - This error occurs when the end date is before the start date in a date range. Please ensure the end date is after or equal to the start date.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The terminal specified by `terminal_id` could not be found for this merchant.
      def retrieve_sales_performance(period:, exclude_voided: Undefined, terminal_id: Undefined)
        args = {}
        args[:period] = period
        args[:exclude_voided] = exclude_voided unless exclude_voided.equal?(Undefined)
        args[:terminal_id] = terminal_id unless terminal_id.equal?(Undefined)
        (v = @real_client.retrieve_sales_performance(**args)) && RetrieveSalesPerformanceResult.new(v)
      end

      # ## Reverse payment
      #
      # Reverses a previously authorized but not yet captured payment. Reversing a payment releases the
      # temporary hold on the customer's funds. This is useful when a transaction is cancelled before it
      # is captured, or when an authorization is no longer needed.
      #
      # Only payments that are in an `AUTHORIZED` status can be reversed. Once a payment is successfully
      # reversed, its status changes to `REVERSED`.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      # May raise WebFunction::BadRequestError with code NOT_REVERSIBLE - Payment is not eligible for reversal. This can happen if the payment is not in an authorized state, the reversal window has passed, or the integration does not support reversals.
      def reverse_payment(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        @real_client.reverse_payment(**args)
      end

      # ## Revoke an API key
      #
      # Permanently revoke an API key to prevent it from being used for authentication. Once revoked, any
      # requests made with this key will be rejected. This is useful when:
      #
      # - An API key has been compromised
      # - You're rotating old API keys as part of security best practices
      # - An employee with access to the key leaves your organization
      #
      # The revocation takes effect immediately and cannot be undone. If you need to restore access,
      # you'll need to create a new API key.
      #
      # The endpoint returns true if the key was successfully revoked.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The API key with the provided ID could not be found in your merchant account. Verify that you're using the correct key_id.
      # May raise WebFunction::BadRequestError with code ALREADY_REVOKED - The API key has already been revoked. No action is needed.
      def revoke_key(key_id:)
        args = {}
        args[:key_id] = key_id
        @real_client.revoke_key(**args)
      end

      # ## Save card
      #
      # Converts a single-use token into a reusable card that can be charged multiple times. This is useful for:
      #
      # - Implementing "save card for later" functionality
      # - Setting up subscription billing
      # - Enabling one-click payments
      #
      # The token must be created with multi-use capability (`usage="multi"`). Single-use tokens cannot be
      # saved as cards. See our [SDK documentation](/api/sdk) for more details on card tokenization.
      #
      # You can optionally provide your own `external_id` to help track the card in your system. This ID
      # can be used instead of the card ID in other API calls.
      #
      # This card will be associated with the specified contact. If `default` is set to `true`,
      # the card will be set as the contact's default card.
      #
      # The endpoint returns the unique card ID that you can use for future charges.
      #
      # Note: A token can only be saved as a card once. Attempting to save the same token multiple times
      # will result in an error.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The token with the provided ID could not be found, or the contact with the provided contact_id could not be found. Verify that you're using the correct IDs.
      # May raise WebFunction::BadRequestError with code NOT_REUSABLE - The token is single-use and cannot be saved as a card. Create a new multi-use token instead.
      # May raise WebFunction::BadRequestError with code ALREADY_SAVED - This token has already been converted to a saved card. Use the existing card ID instead.
      def save_card(external_id: Undefined, token:, contact_id:, contact_email: Undefined, contact_mobile: Undefined, contact_name: Undefined, default: Undefined)
        args = {}
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:token] = token
        args[:contact_id] = contact_id
        args[:contact_email] = contact_email unless contact_email.equal?(Undefined)
        args[:contact_mobile] = contact_mobile unless contact_mobile.equal?(Undefined)
        args[:contact_name] = contact_name unless contact_name.equal?(Undefined)
        args[:default] = default unless default.equal?(Undefined)
        @real_client.save_card(**args)
      end

      # ## Select plan
      #
      # Selects a billing plan for the merchant account. This endpoint allows merchants to choose a plan
      # that suits their business needs. The plan must be one of the plans currently available for the provider.
      #
      # If you upgrade, your new plan starts right away and you’ll only pay the difference for the rest of
      # the month. If you downgrade, you’ll keep your current features until the end of the month, and
      # your new plan will begin on the 1st.
      # May raise WebFunction::BadRequestError with code INVALID_PLAN - The specified plan ID was not found.
      # May raise WebFunction::BadRequestError with code RETIRED_PLAN - The specified plan ID is retired and no longer available for selection.
      def select_plan(plan_id:)
        args = {}
        args[:plan_id] = plan_id
        @real_client.select_plan(**args)
      end

      # ## Send a payment link
      #
      # Queues a payment link for delivery through an active email or SMS communication channel.
      # The recipient is validated and normalized according to the selected channel.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The payment link or communication channel does not exist for this merchant.
      # May raise WebFunction::BadRequestError with code BAD_REQUEST - The payment link, channel, or recipient cannot be used for this delivery.
      def send_payment_link(payment_link_id:, communication_channel_id:, recipient:)
        args = {}
        args[:payment_link_id] = payment_link_id
        args[:communication_channel_id] = communication_channel_id
        args[:recipient] = recipient
        (v = @real_client.send_payment_link(**args)) && SendPaymentLinkResult.new(v)
      end

      # ## Send a payout
      #
      # Send a payout to the primary bank account.
      # May raise WebFunction::BadRequestError with code CONFLICT - A payout with the same external_id already exists in this merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The bank account does not exist or the payout method is not configured for this merchant.
      # May raise WebFunction::BadRequestError with code INSUFFICIENT_BALANCE - The merchant does not have sufficient balance to complete this payout. The requested amount exceeds the available balance in the merchant's account.
      # May raise WebFunction::BadRequestError with code INVALID_AMOUNT - The payout amount exceeds the merchant or payout method limits.
      # May raise WebFunction::BadRequestError with code PAYOUTS_BLOCKED - Payouts are currently blocked for this merchant.
      def send_payout(external_id: Undefined, amount:)
        args = {}
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:amount] = amount
        @real_client.send_payout(**args)
      end

      # ## Send a payout to a contact
      #
      # Sends a payout to an existing contact, or creates the contact in the same request. Provide `recipient_id`
      # to use an existing contact. Without it, the contact is matched by `recipient_email` or `recipient_mobile`,
      # or created when none matches.
      #
      # - **Bank account**: Omit the bank fields to use the contact's primary bank account,
      #   or include `bank_account_id` to specify a particular account. To create a new bank account
      #   on the contact, omit `bank_account_id` and provide `bank_account_number`, `bank_account_name`,
      #   `bank_code`, and `country_code` instead. The two approaches are mutually exclusive.
      #   A newly created contact has no bank account, so provide the bank details.
      # - **Mobile number (PromptPay)**: Set `payout_method` to `mobile_number` and provide `mobile_number`.
      #   Accepts local format (e.g. `0812223333`) or E.164 (e.g. `+66812223333`).
      # - **National ID (PromptPay)**: Set `payout_method` to `national_id` and provide `national_id` (13 digits).
      #
      # When using a bank account, it must belong to the contact and be active (not soft-deleted).
      # May raise WebFunction::BadRequestError with code CONFLICT - A payout with the same external_id already exists in this merchant account.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided recipient_id, the bank account does not exist or does not belong to the contact, or the payout method is not configured for this merchant.
      # May raise WebFunction::BadRequestError with code INVALID_OPERATION - The contact does not have a primary bank account. Please specify a bank_account_id.
      # May raise WebFunction::BadRequestError with code INSUFFICIENT_BALANCE - The merchant does not have sufficient balance to complete this payout. The requested amount exceeds the available balance in the merchant's account.
      # May raise WebFunction::BadRequestError with code INVALID_MOBILE_NUMBER - The mobile number must be a valid local number (e.g. 0812223333) or E.164 number (e.g. +66812223333).
      # May raise WebFunction::BadRequestError with code INVALID_NATIONAL_ID - The national ID must be exactly 13 digits.
      # May raise WebFunction::BadRequestError with code INVALID_AMOUNT - The payout amount exceeds the merchant or payout method limits.
      # May raise WebFunction::BadRequestError with code PAYOUTS_BLOCKED - Payouts are currently blocked for this merchant.
      def send_payout_to_contact(recipient_id: Undefined, payout_method: Undefined, bank_account_id: Undefined, bank_account_number: Undefined, bank_account_name: Undefined, bank_code: Undefined, country_code: Undefined, mobile_number: Undefined, national_id: Undefined, external_id: Undefined, amount:, recipient_mobile: Undefined, recipient_name: Undefined, recipient_email: Undefined, update_contact: Undefined, send_confirmation_email: Undefined)
        args = {}
        args[:recipient_id] = recipient_id unless recipient_id.equal?(Undefined)
        args[:payout_method] = payout_method unless payout_method.equal?(Undefined)
        args[:bank_account_id] = bank_account_id unless bank_account_id.equal?(Undefined)
        args[:bank_account_number] = bank_account_number unless bank_account_number.equal?(Undefined)
        args[:bank_account_name] = bank_account_name unless bank_account_name.equal?(Undefined)
        args[:bank_code] = bank_code unless bank_code.equal?(Undefined)
        args[:country_code] = country_code unless country_code.equal?(Undefined)
        args[:mobile_number] = mobile_number unless mobile_number.equal?(Undefined)
        args[:national_id] = national_id unless national_id.equal?(Undefined)
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:amount] = amount
        args[:recipient_mobile] = recipient_mobile unless recipient_mobile.equal?(Undefined)
        args[:recipient_name] = recipient_name unless recipient_name.equal?(Undefined)
        args[:recipient_email] = recipient_email unless recipient_email.equal?(Undefined)
        args[:update_contact] = update_contact unless update_contact.equal?(Undefined)
        args[:send_confirmation_email] = send_confirmation_email unless send_confirmation_email.equal?(Undefined)
        @real_client.send_payout_to_contact(**args)
      end

      # ## Set default card for a contact
      #
      # Set an existing card as the default card for a contact. The card must already be associated with the contact.
      #
      # If the contact already has a default card set up, using this endpoint will:
      #
      # - Replace the existing default card with the specified one
      #
      # The endpoint returns `true` when the default card is successfully set.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The specified contact was not found, or the card does not exist for this contact.
      def set_default_card(contact_id:, card_id:)
        args = {}
        args[:contact_id] = contact_id
        args[:card_id] = card_id
        @real_client.set_default_card(**args)
      end

      # ## Set entity type
      #
      # Specify whether you are registering as a business or an individual merchant. This is a critical first
      # step in the onboarding process that determines:
      #
      # - What information you'll need to provide
      # - Which features and products will be available to you
      # - Your verification requirements
      #
      # For business merchants:
      #
      # - You'll need to provide business registration details
      # - You can add multiple key people (owners, directors)
      #
      # For individual merchants:
      #
      # - Only personal identification is required
      # - Simpler verification process
      #
      # Important: This setting can only be configured once during initial onboarding and cannot be changed
      # later. Make sure you select the correct entity type for your situation.
      #
      # The endpoint returns true if the entity type was successfully set.
      # May raise WebFunction::BadRequestError with code ALREADY_SET - The entity type has already been set for this merchant account and cannot be changed. You must create a new merchant account if you need a different entity type.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def set_entity_type(entity_type:)
        args = {}
        args[:entity_type] = entity_type
        @real_client.set_entity_type(**args)
      end

      # ## Set merchant classification
      #
      # Specify your business category and the types of products/services you offer. This information helps us:
      #
      # - Configure the right payment features for your business
      # - Apply appropriate transaction limits and fees
      # - Meet regulatory requirements for your business type
      #
      # You'll need to provide:
      #
      # 1. A Merchant Category Code (MCC) - This is a 4-digit code that classifies your primary business activity
      # 2. Product types - The categories of products or services you sell
      #
      # You can optionally declare the transaction volume you expect to process. We use those
      # figures to monitor your account for unexpected activity. Both amounts are expressed in
      # the smallest currency unit (subunits) of your funding currency, must be a positive
      # integer greater than 0, and can be set or changed at any point while onboarding is in
      # draft. Omitted arguments are left unchanged.
      #
      # Important: Your business category and product types can only be set once during initial
      # onboarding and cannot be changed later. Make sure you select the correct classification
      # that best represents your business.
      #
      # The endpoint returns true if the classification was successfully set.
      # May raise WebFunction::BadRequestError with code ALREADY_SET - The merchant classification has already been set for this account and cannot be changed. You must create a new merchant account if you need a different classification.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def set_merchant_classification(category_code:, product_types:, expected_monthly_transaction_amount: Undefined, expected_maximum_transaction_amount: Undefined)
        args = {}
        args[:category_code] = category_code
        args[:product_types] = product_types
        args[:expected_monthly_transaction_amount] = expected_monthly_transaction_amount unless expected_monthly_transaction_amount.equal?(Undefined)
        args[:expected_maximum_transaction_amount] = expected_maximum_transaction_amount unless expected_maximum_transaction_amount.equal?(Undefined)
        @real_client.set_merchant_classification(**args)
      end

      # ## Set primary bank account
      #
      # Configure the bank account where you want to receive payouts from your payment transactions. This bank account will be used for:
      #
      # - Receiving settlement funds from successful payments
      # - Automated payouts based on your payout schedule
      # - Manual payout requests
      #
      # If you already have a primary bank account set up, using this endpoint will:
      #
      # - Replace your existing primary bank account with the new one
      # - Keep the old bank account record for audit purposes
      # - Immediately start using the new account for future payouts
      #
      # Important: The bank account must be in the same country as your payment provider. For example, if your provider is in Thailand, you must provide a Thai bank account.
      #
      # The endpoint returns a unique identifier for the bank account that you can use to reference it in other API calls.
      # May raise WebFunction::BadRequestError with code COUNTRY_MISMATCH - The bank account's country code does not match your payment provider's country. You must provide a bank account in the same country as your provider to receive payouts.
      def set_primary_bank_account(bank_code:, number:, name:, country_code:)
        args = {}
        args[:bank_code] = bank_code
        args[:number] = number
        args[:name] = name
        args[:country_code] = country_code
        @real_client.set_primary_bank_account(**args)
      end

      # ## Set primary bank account for a contact
      #
      # Set an existing bank account as the primary bank account for a contact. The bank account must already be associated with the contact.
      #
      # If the contact already has a primary bank account set up, using this endpoint will:
      #
      # - Replace the existing primary bank account with the specified one
      #
      # The endpoint returns `true` when the primary bank account is successfully set.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id, or the bank account with the provided bank_account_id does not exist or does not belong to the contact.
      def set_primary_contact_bank_account(contact_id:, bank_account_id:)
        args = {}
        args[:contact_id] = contact_id
        args[:bank_account_id] = bank_account_id
        @real_client.set_primary_contact_bank_account(**args)
      end

      # ## Start checkout
      #
      # Initiates a new checkout session. A checkout session represents a customer's intent to pay and
      # provides a secure URL where they can complete their transaction.
      #
      # This endpoint is typically used in web integrations where you want to redirect your customer to a
      # hosted payment page.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The installation could not be found with the provided ID.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - This installation is currently disabled.
      def start_checkout(installation_id:, amount:, currency:, interest_bearer: Undefined, return_url:, external_id: Undefined, customer_id: Undefined, customer_email: Undefined, customer_mobile: Undefined, customer_name: Undefined)
        args = {}
        args[:installation_id] = installation_id
        args[:amount] = amount
        args[:currency] = currency
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        args[:return_url] = return_url
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:customer_id] = customer_id unless customer_id.equal?(Undefined)
        args[:customer_email] = customer_email unless customer_email.equal?(Undefined)
        args[:customer_mobile] = customer_mobile unless customer_mobile.equal?(Undefined)
        args[:customer_name] = customer_name unless customer_name.equal?(Undefined)
        (v = @real_client.start_checkout(**args)) && StartCheckoutResult.new(v)
      end

      # ## Start a payment on a terminal
      #
      # This endpoint initiates a payment flow on a specific terminal. It selects a payment method and notifies the terminal device to start the payment process.
      #
      # When called, it will notify the terminal device to start the payment process.
      #
      # It returns true if the notification was sent.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The terminal could not be found.
      # May raise WebFunction::BadRequestError with code INVALID_ARGUMENT - The payment method is not allowed or the amount is invalid.
      # May raise WebFunction::BadRequestError with code NO_INSTALLATION - The terminal is not properly configured with an installation.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - This installation is currently disabled.
      def start_payment_on_terminal(external_id: Undefined, terminal_id:, amount:, currency:, payment_method:, capture: Undefined)
        args = {}
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:terminal_id] = terminal_id
        args[:amount] = amount
        args[:currency] = currency
        args[:payment_method] = payment_method
        args[:capture] = capture unless capture.equal?(Undefined)
        @real_client.start_payment_on_terminal(**args)
      end

      # ## Subscribe to topics
      #
      # Subscribes an email address to one or more notification topics for this merchant.
      # The email will receive notifications when events related to those topics occur.
      #
      # This endpoint supports both create and update operations:
      #
      # - **Create**: When no subscriptions exist for the email+merchant combination.
      # - **Update**: When subscriptions exist, it will replace existing subscriptions for that email+merchant with the new ones.
      #
      # You can subscribe to multiple topics at once by providing an array of topic IDs.
      # The language parameter determines the language of the notifications sent to this email.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - One or more notification topics with the specified IDs could not be found.
      def subscribe_to_topics(email:, language:, notification_topic_ids:)
        args = {}
        args[:email] = email
        args[:language] = language
        args[:notification_topic_ids] = notification_topic_ids
        @real_client.subscribe_to_topics(**args)
      end

      # ## Supported payment methods
      #
      # Get a list of all payment methods that are currently enabled for your merchant account.
      #
      # The endpoint returns an array of payment methods that you can use with other API endpoints. Each payment method
      # lists the `platforms` it is available on, so you only offer the payment methods that fit the platform the payment happens on.
      def supported_payment_methods
        (@real_client.supported_payment_methods || []).map { |item| SupportedPaymentMethodsResult.new(item) }
      end

      # ## Sync object metadata
      #
      # Metadata allows you to store and manage arbitrary JSON data associated with your merchant account.
      #
      # ### Keys and Objects
      #
      # Metadata is organized into objects, each identified by a unique `key`. The `key` is a string of your choice that serves as a unique identifier for the metadata record.
      #
      # ### Nested Paths
      #
      # You can use dot-separated paths (e.g., `settings.theme` or `user.profile.id`) to update specific parts of a metadata object without overwriting the entire thing.
      #
      # - If the path does not exist, it will be created.
      # - If no path is provided, the entire metadata object for the given key is replaced.
      #
      # ### Expiration (TTL)
      #
      # Each metadata record has an expiration date.
      #
      # - By default, metadata expires after 2 years from its last update.
      # - You can specify a custom `ttl` (Time To Live) in seconds when syncing.
      # - Metadata can be deleted by syncing it with a `ttl` of `0`.
      # - Expired metadata can be reactivated by syncing it again.
      #
      # ### Optimistic Locking
      #
      # To prevent concurrent updates from overwriting each other, you can use the `version` argument. If provided, the update will only succeed if it matches the current `version` (lock_version) of the record.
      #
      # ### Limits
      #
      # - Individual metadata records are limited to 4 KB.
      # - For test accounts, the total size of all metadata records is limited to 10 MB.
      def sync_metadata(key:, path: Undefined, metadata:, version: Undefined, ttl: Undefined)
        args = {}
        args[:key] = key
        args[:path] = path unless path.equal?(Undefined)
        args[:metadata] = metadata
        args[:version] = version unless version.equal?(Undefined)
        args[:ttl] = ttl unless ttl.equal?(Undefined)
        @real_client.sync_metadata(**args)
      end

      # ## Turn off auto payout
      #
      # Disable automatic payouts to your bank account. When auto payout is turned off:
      #
      # - Funds from your transactions will accumulate in your merchant balance
      # - You'll need to manually request payouts when you want to withdraw funds
      # - You can still view your available balance and payout history
      # - You can turn auto payout back on at any time
      #
      # This is useful if you want more control over when you receive your funds, for example:
      #
      # - To accumulate a larger balance before withdrawing
      # - To manually time your payouts with your business needs
      # - To temporarily hold funds during account changes
      #
      # The endpoint returns true if auto payout was successfully disabled.
      def turn_off_auto_payout
        @real_client.turn_off_auto_payout
      end

      # ## Turn on auto payout
      #
      # Enable automatic transfers of your available balance to your bank account on a regular schedule. When auto payout is turned on:
      #
      # - Your available balance will automatically be transferred to your primary bank account
      # - Payouts will occur according to your chosen frequency (daily or weekly)
      # - You don't need to manually request payouts
      # - You can still view your payout history and track upcoming payouts
      # - You can turn auto payout off at any time if you want to switch back to manual payouts
      #
      # This is useful if you want a hands-off approach to managing your funds, receive your money as soon as it's available.
      #
      # Note that you must have a primary bank account set up before enabling auto payout. Use the [set-primary-bank-account](/api/merchants/set-primary-bank-account) endpoint first if you haven't configured one yet.
      # May raise WebFunction::BadRequestError with code NO_PRIMARY_BANK_ACCOUNT - This error occurs when the merchant does not have a primary bank account.
      def turn_on_auto_payout(frequency:)
        args = {}
        args[:frequency] = frequency
        @real_client.turn_on_auto_payout(**args)
      end

      # ## Unlink bank account from a contact
      #
      # Unlink (soft delete) a bank account from a contact. The bank account will be marked as deleted but the record will be preserved for audit purposes.
      #
      # Bank accounts include a `deletable` attribute that indicates whether the bank account can be deleted. The frontend should check this attribute before attempting to delete a bank account. If a bank account cannot be deleted, set another bank account as the primary using the `set-primary-contact-bank-account` endpoint, which will update the `deletable` attribute accordingly.
      #
      # The endpoint returns `true` when the bank account is successfully unlinked.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id, or the bank account with the provided bank_account_id does not exist or does not belong to the contact.
      # May raise WebFunction::BadRequestError with code INVALID_OPERATION - Cannot delete primary bank account when contact has multiple accounts. Set another account as primary first.
      def unlink_bank_account(contact_id:, bank_account_id:)
        args = {}
        args[:contact_id] = contact_id
        args[:bank_account_id] = bank_account_id
        @real_client.unlink_bank_account(**args)
      end

      # ## Unsubscribe from all topics
      #
      # Unsubscribe a specific email address from all notification topics within this merchant.
      # This will remove all existing subscriptions for the specified email address.
      #
      # This endpoint requires authentication and will return true if the unsubscribe operation was successful.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No subscriptions found for the specified email address.
      def unsubscribe_from_all_topics(email:)
        args = {}
        args[:email] = email
        @real_client.unsubscribe_from_all_topics(**args)
      end

      # ## Update a bank account
      #
      # Update the details of an existing bank account linked to a contact. Only the fields you provide will be updated — omitted fields will remain unchanged.
      #
      # The endpoint returns the updated bank account object.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id, or the bank account does not exist or does not belong to the contact.
      # May raise WebFunction::BadRequestError with code INVALID_PRIMARY - Cannot unset primary on the current primary bank account. Set another bank account as primary instead.
      def update_bank_account(contact_id:, bank_account_id:, name: Undefined, primary: Undefined, external_id: Undefined)
        args = {}
        args[:contact_id] = contact_id
        args[:bank_account_id] = bank_account_id
        args[:name] = name unless name.equal?(Undefined)
        args[:primary] = primary unless primary.equal?(Undefined)
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        @real_client.update_bank_account(**args)
      end

      # ## Update branding
      #
      # Update the visual branding settings for your merchant account. This includes colors, typography,
      # button styling, and display preferences for your payment interface.
      #
      # All parameters are optional - you can update individual settings without affecting others. The
      # endpoint returns true if the branding was successfully updated.
      #
      # **Note:** For uploading logo and sidebar images, use the `generate-branding-upload-url` and
      # `confirm-branding-upload` endpoints.
      # May raise WebFunction::BadRequestError with code INVALID_RECORD - This error occurs when the record contains invalid parameters. Common cases include invalid hex color formats, unsupported font families, or invalid font variants for the specified font family.
      def update_branding(primary_color: Undefined, secondary_color: Undefined, sidebar_color: Undefined, sidebar_background_type: Undefined, tile_sidebar_image: Undefined, hide_logo: Undefined, shop_name_font_family: Undefined, shop_name_font_variant: Undefined, heading_font_family: Undefined, heading_font_variant: Undefined, body_font_family: Undefined, body_font_variant: Undefined, use_iso_code: Undefined, hide_non_significant_zeros: Undefined, show_amount_in_button: Undefined, symbol_placement: Undefined, default_button_text: Undefined, button_shape: Undefined)
        args = {}
        args[:primary_color] = primary_color unless primary_color.equal?(Undefined)
        args[:secondary_color] = secondary_color unless secondary_color.equal?(Undefined)
        args[:sidebar_color] = sidebar_color unless sidebar_color.equal?(Undefined)
        args[:sidebar_background_type] = sidebar_background_type unless sidebar_background_type.equal?(Undefined)
        args[:tile_sidebar_image] = tile_sidebar_image unless tile_sidebar_image.equal?(Undefined)
        args[:hide_logo] = hide_logo unless hide_logo.equal?(Undefined)
        args[:shop_name_font_family] = shop_name_font_family unless shop_name_font_family.equal?(Undefined)
        args[:shop_name_font_variant] = shop_name_font_variant unless shop_name_font_variant.equal?(Undefined)
        args[:heading_font_family] = heading_font_family unless heading_font_family.equal?(Undefined)
        args[:heading_font_variant] = heading_font_variant unless heading_font_variant.equal?(Undefined)
        args[:body_font_family] = body_font_family unless body_font_family.equal?(Undefined)
        args[:body_font_variant] = body_font_variant unless body_font_variant.equal?(Undefined)
        args[:use_iso_code] = use_iso_code unless use_iso_code.equal?(Undefined)
        args[:hide_non_significant_zeros] = hide_non_significant_zeros unless hide_non_significant_zeros.equal?(Undefined)
        args[:show_amount_in_button] = show_amount_in_button unless show_amount_in_button.equal?(Undefined)
        args[:symbol_placement] = symbol_placement unless symbol_placement.equal?(Undefined)
        args[:default_button_text] = default_button_text unless default_button_text.equal?(Undefined)
        args[:button_shape] = button_shape unless button_shape.equal?(Undefined)
        @real_client.update_branding(**args)
      end

      # ## Update business details
      #
      # Updates the business details for a merchant during the onboarding process. This endpoint is only available
      # while your merchant account is in the onboarding phase. Once onboarding is complete, these details cannot
      # be modified through the API.
      #
      # This endpoint only works for merchants registered as a business entity (entity_type = "business"). Individual
      # merchants cannot use this endpoint.
      #
      # You can either:
      #
      # - Provide all required fields for a complete update
      # - Set partial_update=true to update only specific fields
      #
      # All dates should be provided in ISO8601 format (YYYY-MM-DD).
      # May raise WebFunction::BadRequestError with code NOT_BUSINESS - This error occurs when attempting to update business details for a merchant that is not registered as a business entity. Business details can only be updated for business merchants, not individual merchants.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def update_business_details(partial_update: Undefined, legal_name:, registration_number:, registration_date: Undefined, address_street_1:, address_street_2: Undefined, postal_code:, city:, country:, primary_administrative_division:, operation_address_street_1: Undefined, operation_address_street_2: Undefined, operation_address_postal_code: Undefined, operation_address_city: Undefined, operation_address_country: Undefined, operation_address_primary_administrative_division: Undefined, use_business_registration_as_operation_address: Undefined, branch:, legal_structure:, kym_contact_person:, kym_contact_phone:)
        args = {}
        args[:partial_update] = partial_update unless partial_update.equal?(Undefined)
        args[:legal_name] = legal_name
        args[:registration_number] = registration_number
        args[:registration_date] = registration_date unless registration_date.equal?(Undefined)
        args[:address_street_1] = address_street_1
        args[:address_street_2] = address_street_2 unless address_street_2.equal?(Undefined)
        args[:postal_code] = postal_code
        args[:city] = city
        args[:country] = country
        args[:primary_administrative_division] = primary_administrative_division
        args[:operation_address_street_1] = operation_address_street_1 unless operation_address_street_1.equal?(Undefined)
        args[:operation_address_street_2] = operation_address_street_2 unless operation_address_street_2.equal?(Undefined)
        args[:operation_address_postal_code] = operation_address_postal_code unless operation_address_postal_code.equal?(Undefined)
        args[:operation_address_city] = operation_address_city unless operation_address_city.equal?(Undefined)
        args[:operation_address_country] = operation_address_country unless operation_address_country.equal?(Undefined)
        args[:operation_address_primary_administrative_division] = operation_address_primary_administrative_division unless operation_address_primary_administrative_division.equal?(Undefined)
        args[:use_business_registration_as_operation_address] = use_business_registration_as_operation_address unless use_business_registration_as_operation_address.equal?(Undefined)
        args[:branch] = branch
        args[:legal_structure] = legal_structure
        args[:kym_contact_person] = kym_contact_person
        args[:kym_contact_phone] = kym_contact_phone
        @real_client.update_business_details(**args)
      end

      # ## Update contact
      #
      # Updates an existing contact. The `contact_id` can be either the internal UID
      # (starting with `ctc_`) or the external ID.
      # The service will check for conflicts with other contacts if the new values already exist.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - No contact found with the provided contact_id. The contact may not exist or may belong to a different merchant.
      # May raise WebFunction::BadRequestError with code CONFLICT - A contact with the same email or mobile number already exists. Each contact must have unique values for these fields.
      # May raise WebFunction::BadRequestError with code VALIDATION_ERROR - Validation failed. At least one of contact_email or contact_mobile must be provided. If contact_email is provided, it must be a valid email format.
      def update_contact(contact_id:, contact_email: Undefined, contact_mobile: Undefined, contact_name: Undefined, favorite: Undefined)
        args = {}
        args[:contact_id] = contact_id
        args[:contact_email] = contact_email unless contact_email.equal?(Undefined)
        args[:contact_mobile] = contact_mobile unless contact_mobile.equal?(Undefined)
        args[:contact_name] = contact_name unless contact_name.equal?(Undefined)
        args[:favorite] = favorite unless favorite.equal?(Undefined)
        @real_client.update_contact(**args)
      end

      # ## Update individual details
      #
      # Updates personal and contact information for an individual merchant account during the onboarding process.
      # This endpoint is only available:
      #
      # - During the initial onboarding phase
      # - For individual merchants (entity_type = "individual")
      # - For local nationals only (foreign nationals cannot register as individual merchants)
      #
      # Once onboarding is complete, these details cannot be modified through the API.
      #
      # You can update information in two ways:
      #
      # - Provide all required fields for a complete update
      # - Set partial_update=true to update only specific fields
      #
      # For identification, you must provide:
      #
      # - Your national ID number
      # - National ID expiry date
      # - For Thai nationals: The 12-digit laser code from the back of your ID card
      #
      # All dates should be provided in ISO8601 format (YYYY-MM-DD). The merchant must be at least 18 years old.
      #
      # Note: If you are a business merchant or your onboarding is complete, this endpoint will not be available.
      # Foreign nationals must register as a business entity instead of an individual merchant.
      # May raise WebFunction::BadRequestError with code NOT_INDIVIDUAL - This error occurs when attempting to update individual details for a business merchant account.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def update_individual_details(partial_update: Undefined, first_name:, middle_name: Undefined, last_name:, first_name_local_language: Undefined, middle_name_local_language: Undefined, last_name_local_language: Undefined, nationality:, national_id:, national_id_expiry_date:, national_id_without_expiry_date: Undefined, thai_national_id_laser_code: Undefined, phone:, date_of_birth:, address_street_1:, address_street_2: Undefined, postal_code:, city:, country:, primary_administrative_division:, operation_address_street_1: Undefined, operation_address_street_2: Undefined, operation_address_postal_code: Undefined, operation_address_city: Undefined, operation_address_country: Undefined, operation_address_primary_administrative_division: Undefined, current_address_street_1: Undefined, current_address_street_2: Undefined, current_address_postal_code: Undefined, current_address_city: Undefined, current_address_country: Undefined, current_address_primary_administrative_division: Undefined, use_residence_registration_as_current_address: Undefined, use_residence_registration_as_operation_address: Undefined)
        args = {}
        args[:partial_update] = partial_update unless partial_update.equal?(Undefined)
        args[:first_name] = first_name
        args[:middle_name] = middle_name unless middle_name.equal?(Undefined)
        args[:last_name] = last_name
        args[:first_name_local_language] = first_name_local_language unless first_name_local_language.equal?(Undefined)
        args[:middle_name_local_language] = middle_name_local_language unless middle_name_local_language.equal?(Undefined)
        args[:last_name_local_language] = last_name_local_language unless last_name_local_language.equal?(Undefined)
        args[:nationality] = nationality
        args[:national_id] = national_id
        args[:national_id_expiry_date] = national_id_expiry_date
        args[:national_id_without_expiry_date] = national_id_without_expiry_date unless national_id_without_expiry_date.equal?(Undefined)
        args[:thai_national_id_laser_code] = thai_national_id_laser_code unless thai_national_id_laser_code.equal?(Undefined)
        args[:phone] = phone
        args[:date_of_birth] = date_of_birth
        args[:address_street_1] = address_street_1
        args[:address_street_2] = address_street_2 unless address_street_2.equal?(Undefined)
        args[:postal_code] = postal_code
        args[:city] = city
        args[:country] = country
        args[:primary_administrative_division] = primary_administrative_division
        args[:operation_address_street_1] = operation_address_street_1 unless operation_address_street_1.equal?(Undefined)
        args[:operation_address_street_2] = operation_address_street_2 unless operation_address_street_2.equal?(Undefined)
        args[:operation_address_postal_code] = operation_address_postal_code unless operation_address_postal_code.equal?(Undefined)
        args[:operation_address_city] = operation_address_city unless operation_address_city.equal?(Undefined)
        args[:operation_address_country] = operation_address_country unless operation_address_country.equal?(Undefined)
        args[:operation_address_primary_administrative_division] = operation_address_primary_administrative_division unless operation_address_primary_administrative_division.equal?(Undefined)
        args[:current_address_street_1] = current_address_street_1 unless current_address_street_1.equal?(Undefined)
        args[:current_address_street_2] = current_address_street_2 unless current_address_street_2.equal?(Undefined)
        args[:current_address_postal_code] = current_address_postal_code unless current_address_postal_code.equal?(Undefined)
        args[:current_address_city] = current_address_city unless current_address_city.equal?(Undefined)
        args[:current_address_country] = current_address_country unless current_address_country.equal?(Undefined)
        args[:current_address_primary_administrative_division] = current_address_primary_administrative_division unless current_address_primary_administrative_division.equal?(Undefined)
        args[:use_residence_registration_as_current_address] = use_residence_registration_as_current_address unless use_residence_registration_as_current_address.equal?(Undefined)
        args[:use_residence_registration_as_operation_address] = use_residence_registration_as_operation_address unless use_residence_registration_as_operation_address.equal?(Undefined)
        @real_client.update_individual_details(**args)
      end

      # ## Update an API key
      #
      # Update the name of an existing API key for your merchant account. This allows you to change the descriptive
      # name that helps identify the key's purpose.
      #
      # The key's actual value and functionality remain unchanged - only the display name is modified.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no active API key with the provided ID exists in your merchant account.
      def update_key(key_id:, name:)
        args = {}
        args[:key_id] = key_id
        args[:name] = name
        @real_client.update_key(**args)
      end

      # ## Update a key person
      #
      # Update details of a key person in your business merchant account. Key people are individuals
      # who have significant control or influence over your business, such as:
      #
      # - Ultimate Beneficial Owners (UBOs) who own 25% or more of the business
      # - Authorized Signatories who can legally represent and make decisions for
      #   the business
      #
      # This endpoint is only available for business merchants, not
      # individual merchants.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no key person with the provided ID exists in your merchant account.
      # May raise WebFunction::BadRequestError with code NOT_EDITABLE - This error occurs when the onboarding status of the merchant is no longer in draft.
      def update_key_person(key_person_id:, first_name:, middle_name: Undefined, last_name:, first_name_local_language: Undefined, middle_name_local_language: Undefined, last_name_local_language: Undefined, date_of_birth:, nationality:, type:, percentage_of_ownership: Undefined, authorized_director: Undefined, national_id: Undefined, national_id_expiry_date: Undefined, national_id_without_expiry_date: Undefined, passport_number: Undefined, passport_expiry_date: Undefined, address_street_1: Undefined, address_street_2: Undefined, postal_code: Undefined, city: Undefined, primary_administrative_division: Undefined, country: Undefined, current_address_street_1: Undefined, current_address_street_2: Undefined, current_address_postal_code: Undefined, current_address_city: Undefined, current_address_primary_administrative_division: Undefined, current_address_country: Undefined, use_residence_registration_as_current_address: Undefined)
        args = {}
        args[:key_person_id] = key_person_id
        args[:first_name] = first_name
        args[:middle_name] = middle_name unless middle_name.equal?(Undefined)
        args[:last_name] = last_name
        args[:first_name_local_language] = first_name_local_language unless first_name_local_language.equal?(Undefined)
        args[:middle_name_local_language] = middle_name_local_language unless middle_name_local_language.equal?(Undefined)
        args[:last_name_local_language] = last_name_local_language unless last_name_local_language.equal?(Undefined)
        args[:date_of_birth] = date_of_birth
        args[:nationality] = nationality
        args[:type] = type
        args[:percentage_of_ownership] = percentage_of_ownership unless percentage_of_ownership.equal?(Undefined)
        args[:authorized_director] = authorized_director unless authorized_director.equal?(Undefined)
        args[:national_id] = national_id unless national_id.equal?(Undefined)
        args[:national_id_expiry_date] = national_id_expiry_date unless national_id_expiry_date.equal?(Undefined)
        args[:national_id_without_expiry_date] = national_id_without_expiry_date unless national_id_without_expiry_date.equal?(Undefined)
        args[:passport_number] = passport_number unless passport_number.equal?(Undefined)
        args[:passport_expiry_date] = passport_expiry_date unless passport_expiry_date.equal?(Undefined)
        args[:address_street_1] = address_street_1 unless address_street_1.equal?(Undefined)
        args[:address_street_2] = address_street_2 unless address_street_2.equal?(Undefined)
        args[:postal_code] = postal_code unless postal_code.equal?(Undefined)
        args[:city] = city unless city.equal?(Undefined)
        args[:primary_administrative_division] = primary_administrative_division unless primary_administrative_division.equal?(Undefined)
        args[:country] = country unless country.equal?(Undefined)
        args[:current_address_street_1] = current_address_street_1 unless current_address_street_1.equal?(Undefined)
        args[:current_address_street_2] = current_address_street_2 unless current_address_street_2.equal?(Undefined)
        args[:current_address_postal_code] = current_address_postal_code unless current_address_postal_code.equal?(Undefined)
        args[:current_address_city] = current_address_city unless current_address_city.equal?(Undefined)
        args[:current_address_primary_administrative_division] = current_address_primary_administrative_division unless current_address_primary_administrative_division.equal?(Undefined)
        args[:current_address_country] = current_address_country unless current_address_country.equal?(Undefined)
        args[:use_residence_registration_as_current_address] = use_residence_registration_as_current_address unless use_residence_registration_as_current_address.equal?(Undefined)
        @real_client.update_key_person(**args)
      end

      # ## Update merchant settings
      #
      # Updates self-service settings for your merchant account, such as communication language and payout authorization requirements.
      #
      # To view system properties set up for you by Reservepay, use `retrieve-configuration`.
      def update_merchant_settings(preferred_communication_language: Undefined, payout_contact_authorization_required: Undefined, payout_allow_self_authorization: Undefined, payout_skip_authorization_for_api_key: Undefined)
        args = {}
        args[:preferred_communication_language] = preferred_communication_language unless preferred_communication_language.equal?(Undefined)
        args[:payout_contact_authorization_required] = payout_contact_authorization_required unless payout_contact_authorization_required.equal?(Undefined)
        args[:payout_allow_self_authorization] = payout_allow_self_authorization unless payout_allow_self_authorization.equal?(Undefined)
        args[:payout_skip_authorization_for_api_key] = payout_skip_authorization_for_api_key unless payout_skip_authorization_for_api_key.equal?(Undefined)
        @real_client.update_merchant_settings(**args)
      end

      # ## Update a sales channel
      #
      # Update a sales channel for the merchant. Note that the platform cannot be changed after creation.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no sales channel with the provided ID exists in your merchant account.
      def update_sales_channel(sales_channel_id:, url: Undefined, demo_url: Undefined, instructions: Undefined)
        args = {}
        args[:sales_channel_id] = sales_channel_id
        args[:url] = url unless url.equal?(Undefined)
        args[:demo_url] = demo_url unless demo_url.equal?(Undefined)
        args[:instructions] = instructions unless instructions.equal?(Undefined)
        @real_client.update_sales_channel(**args)
      end

      # ## Update terminal
      #
      # Updates an existing terminal. Returns the `terminal_id`.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - Terminal or installation not found.
      # May raise WebFunction::BadRequestError with code INVALID_ARGUMENT - Terminal cannot delegate to itself, the delegated terminal already has a delegation configured or is already used by another terminal, or kiosk_mode cannot be combined with delegated_terminal_id.
      def update_terminal(terminal_id:, name: Undefined, external_id: Undefined, installation_id: Undefined, branch_name: Undefined, kiosk_mode: Undefined, delegated_terminal_id: Undefined)
        args = {}
        args[:terminal_id] = terminal_id
        args[:name] = name unless name.equal?(Undefined)
        args[:external_id] = external_id unless external_id.equal?(Undefined)
        args[:installation_id] = installation_id unless installation_id.equal?(Undefined)
        args[:branch_name] = branch_name unless branch_name.equal?(Undefined)
        args[:kiosk_mode] = kiosk_mode unless kiosk_mode.equal?(Undefined)
        args[:delegated_terminal_id] = delegated_terminal_id unless delegated_terminal_id.equal?(Undefined)
        @real_client.update_terminal(**args)
      end

      # ## Validate bank account
      #
      # Check with the bank that a bank account exists and that its holder name matches the name
      # you expect, before adding the bank account to a contact.
      #
      # The account holder name from the bank is compared against `name` and `local_name`.
      # Titles such as `Mr.` or `นาย` are ignored.
      # `match` is `true` when `score` is greater than or equal to `sensitivity`.
      #
      # A fee is charged per call. Contact support for pricing.
      # May raise WebFunction::BadRequestError with code NOT_SUPPORTED - Bank account validation is not available for your account.
      # May raise WebFunction::BadRequestError with code LOOKUP_FAILED - The bank account could not be looked up with the bank. Please try again later.
      def validate_bank_account(bank_code:, account_number:, name: Undefined, local_name: Undefined, sensitivity:)
        args = {}
        args[:bank_code] = bank_code
        args[:account_number] = account_number
        args[:name] = name unless name.equal?(Undefined)
        args[:local_name] = local_name unless local_name.equal?(Undefined)
        args[:sensitivity] = sensitivity
        (v = @real_client.validate_bank_account(**args)) && ValidateBankAccountResult.new(v)
      end

      # ## Void payment
      #
      # Voids a previously captured payment that has not yet been settled. Voids are typically used to cancel
      # a transaction before funds are officially transferred. Unlike refunds, which occur after settlement,
      # a void happens before the transaction is finalized on the customer's statement.
      #
      # Only payments that are in a `SUCCESSFUL` (captured) status and have not yet been settled can be voided.
      # Once a payment is successfully voided, its status changes to `VOIDED`.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when no payment with the provided ID exists in your merchant account. Double check that you're using the correct payment ID.
      # May raise WebFunction::BadRequestError with code NOT_VOIDABLE - Payment is not eligible for void. This can happen if the payment is not in a captured state, has already settled into a statement, the void window has passed, or the integration does not support voids.
      def void_payment(payment_id:)
        args = {}
        args[:payment_id] = payment_id
        @real_client.void_payment(**args)
      end

      # Escape hatch for calling an endpoint this file doesn't declare a
      # typed method for.
      def call(endpoint_name, args = {})
        @real_client.call(endpoint_name, args)
      end

      def package
        @real_client.package
      end

      def bearer_auth=(value)
        @real_client.bearer_auth = value
      end

      def version=(value)
        @real_client.version = value
      end

      def pipeline=(value)
        @real_client.pipeline = value
      end

    end
  end
end
