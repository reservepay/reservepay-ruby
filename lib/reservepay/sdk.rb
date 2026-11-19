# Generated client for the Reservepay SDK API webfunction package.
# Source: https://api.reservepay.com/sdk
#
# Wraps the real web_function gem (github.com/robinclart/web_function) -
# every method here calls straight through to the real dynamic client.
# frozen_string_literal: true

require "web_function"

module Reservepay
  module SDK
    class InstallmentPlanAttributes
      def initialize(raw)
        @raw = raw
      end

      # The ID of the installment plan. Pass this to `select-payment-method` to confirm the customer's choice.
      def installment_plan_id
        @raw["installment_plan_id"]
      end

      # Human-readable name of the installment plan.
      def name
        @raw["name"]
      end

      # Number of monthly installments.
      def months
        @raw["months"]
      end

      # The monthly interest rate charged to the customer, as a percentage on a 0-100 scale (e.g. `1.5` means 1.5% per month). `0.0` when the merchant bears the interest or the plan is interest-free; see `interest_bearer`.
      def interest_rate
        @raw["interest_rate"]
      end

      # Who bears the interest. When `merchant`, the customer pays only the original amount split across months. When `customer`, the customer pays the original amount plus interest.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # Amount the customer pays per month, in the smallest currency unit. Computed against the requested payment amount and interest bearer.
      def monthly_amount
        @raw["monthly_amount"]
      end

      # Total amount charged to the customer across all installments, in the smallest currency unit.
      def total_amount
        @raw["total_amount"]
      end

      # Interest charged to the customer per month, in the smallest currency unit. `0` when the merchant bears the interest or the plan is interest-free; see `interest_bearer`.
      def monthly_interest_amount
        @raw["monthly_interest_amount"]
      end

      # Total interest charged to the customer across all installments, in the smallest currency unit. `0` when the merchant bears the interest or the plan is interest-free; see `interest_bearer`.
      def total_interest_amount
        @raw["total_interest_amount"]
      end

      # The three-letter ISO currency code for the amounts.
      def currency
        @raw["currency"]
      end

      # The name of the bank or provider offering this installment plan.
      def bank_name
        @raw["bank_name"]
      end

      # The display name of the bank or provider offering this installment plan.
      def bank_display_name
        @raw["bank_display_name"]
      end

    end

    class RetrieveCheckoutResult
      def initialize(raw)
        @raw = raw
      end

      # The merchant's return URL the customer is sent back to when abandoning the checkout, or null if not set.
      def return_url
        @raw["return_url"]
      end

    end

    class BankAttributes
      def initialize(raw)
        @raw = raw
      end

      # The name of the bank offering the installment plans.
      def name
        @raw["name"]
      end

      # The display name of the bank
      def display_name
        @raw["display_name"]
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

      # the flow of the payment method.
      def flow
        @raw["flow"]
      end

      # The category of the payment method.
      def category
        @raw["category"]
      end

      # Whether the SDK should show billing-address fields for this payment method. This combines the installation's `address_capture` setting with the payment method's address requirement.
      def requires_address
        @raw["requires_address"]
      end

      # The billing-address fields the SDK should require. Installation-level required capture uses the payment method's configured fields; an empty configuration uses every field except `street_address_2`.
      def required_fields
        @raw["required_fields"]
      end

      # The banks offering installment plans for this payment method and interest bearer. Always empty for payment methods that are not installments.
      def banks
        (@raw["banks"] || []).map { |item| BankAttributes.new(item) }
      end

    end

    class RetrieveInstallationSettingsResult
      def initialize(raw)
        @raw = raw
      end

      # The ID of the installation.
      def installation_id
        @raw["installation_id"]
      end

      # The name of the installation.
      def name
        @raw["name"]
      end

      # The platform type of the installation (e.g., `WEB`, `IOS`, `ANDROID`, `TERMINAL`).
      def platform
        @raw["platform"]
      end

      # The unique identifier for the installation on the platform.
      def identifier
        @raw["identifier"]
      end

      # List of payment methods supported by this installation. Only includes payment methods available on the installation's platform.
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

      # Billing-address capture configuration for this installation. 'disabled' means no address collection, 'optional' means address fields are shown but optional, 'required' means the fields listed in each payment method's `required_fields` are mandatory.
      def address_capture
        @raw["address_capture"]
      end

      # The name of the merchant that owns this installation.
      def merchant_name
        @raw["merchant_name"]
      end

      # The merchant's default for who bears installment interest. When `merchant`, the customer pays only the original amount split across the installment months. When `customer`, the customer pays the original amount plus interest. `null` when the merchant has no default configured, in which case `interest_bearer` must be passed explicitly to `list-installment-plans` and `select-payment-method`.
      def interest_bearer
        @raw["interest_bearer"]
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

      # URL for the dark logo (for dark backgrounds).
      def dark_logo_url
        @raw["dark_logo_url"]
      end

      # URL for the sidebar background image.
      def sidebar_image_url
        @raw["sidebar_image_url"]
      end

    end

    class RetrievePaymentLinkResult
      def initialize(raw)
        @raw = raw
      end

      # A description of the payment link.
      def description
        @raw["description"]
      end

      # The expiration time of the payment link as a Unix timestamp, or null if it does not expire.
      def expires_at
        @raw["expires_at"]
      end

    end

    class RetrievePaymentSessionResult
      def initialize(raw)
        @raw = raw
      end

      # The payment amount in the smallest currency unit (e.g. cents for USD).
      def amount
        @raw["amount"]
      end

      # The currency code for the payment amount (e.g. 'THB', 'USD').
      def currency
        @raw["currency"]
      end

      # The name of the payment method.
      def payment_method
        @raw["payment_method"]
      end

      # The display name of the payment method.
      def payment_method_display_name
        @raw["payment_method_display_name"]
      end

      # The first 6 digits of the card number. Null for non-card payment methods or card sessions without a token.
      def card_first_digits
        @raw["card_first_digits"]
      end

      # The last 2 digits of the card number. Null for non-card payment methods or card sessions without a token.
      def card_last_digits
        @raw["card_last_digits"]
      end

      # The card network, such as visa or mastercard. Null for non-card payment methods or card sessions without a token.
      def card_network
        @raw["card_network"]
      end

      # Number of monthly installments for this payment. Null for non-installment payment methods.
      def installment_term
        @raw["installment_term"]
      end

      # Who bears the installment interest. Null for non-installment payment methods.
      def interest_bearer
        @raw["interest_bearer"]
      end

      # The monthly interest rate charged to the customer, as a percentage on a 0-100 scale (e.g. `1.5` means 1.5% per month), snapshotted when the payment method was selected. `0.0` when the merchant bears the interest or the plan is interest-free; see `interest_bearer`. Null for non-installment payment methods.
      def installment_interest_rate
        @raw["installment_interest_rate"]
      end

      # Amount charged to the customer per month, in the smallest currency unit. Null for non-installment payment methods.
      def installment_monthly_amount
        @raw["installment_monthly_amount"]
      end

      # Total amount charged to the customer across all installments, in the smallest currency unit. Null for non-installment payment methods.
      def installment_total_amount
        @raw["installment_total_amount"]
      end

      # Total interest charged to the customer across all installments, in the smallest currency unit, derived from the rate snapshotted when the payment method was selected. `0` when the merchant bears the interest or the plan is interest-free; see `interest_bearer`. Null for non-installment payment methods.
      def installment_total_interest_amount
        @raw["installment_total_interest_amount"]
      end

      # The name of the bank offering the installment plan. Null for non-installment payment methods.
      def installment_bank_name
        @raw["installment_bank_name"]
      end

      # The display name of the bank offering the installment plan. Null for non-installment payment methods.
      def installment_bank_display_name
        @raw["installment_bank_display_name"]
      end

      # The date when the payment was authorized in ISO 8601 format. Null if payment has not been authorized.
      def payment_authorized_at
        @raw["payment_authorized_at"]
      end

      # The date when the payment was captured in ISO 8601 format. Null if payment has not been captured.
      def payment_captured_at
        @raw["payment_captured_at"]
      end

      # The date when the payment was voided in ISO 8601 format. Null if payment has not been voided.
      def payment_voided_at
        @raw["payment_voided_at"]
      end

      # The current status of the payment.
      def status
        @raw["status"]
      end

      # First reference number for the payment. Can be used for external tracking or merchant-specific identifiers.
      def payment_ref1
        @raw["payment_ref1"]
      end

      # Second reference number for the payment. Can be used for external tracking or merchant-specific identifiers.
      def payment_ref2
        @raw["payment_ref2"]
      end

      # Third reference number for the payment. Can be used for external tracking or merchant-specific identifiers.
      def payment_ref3
        @raw["payment_ref3"]
      end

      # The ID of the terminal that created the payment session, if any.
      def terminal_id
        @raw["terminal_id"]
      end

      # The expiration time of the payment as a Unix timestamp, or null if it does not expire.
      def expires_at
        @raw["expires_at"]
      end

    end

    # Sentinel distinguishing "caller omitted this optional argument" from
    # "caller explicitly passed nil" - forwarding nil either way would send
    # the real client (and the real server) an explicit JSON null for an
    # argument that was never actually given.
    Undefined = ::Object.new.freeze

    class Client
      # The package endpoint this client was generated from.
      SOURCE_URL = "https://api.reservepay.com/sdk"

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

      # ## Check the status of the payment session
      #
      # This endpoint allows you to check the current status of a payment session. The payment session
      # goes through several states during its lifecycle:
      #
      # - `PENDING`: The customer has requested to start the payment flow but hasn't begun yet
      # - `INITIATED`: You (the merchant) have initiated the payment flow and it's ready for the customer
      # - `SUCCESSFUL`: Payment completed successfully
      # - `FAILED`: Payment failed, was declined or was cancelled
      # - `EXPIRED`: Payment expired before completion
      #
      # You should poll this endpoint periodically to track the payment progress. We recommend polling
      # not faster than every 1 second.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or payment session with the IDs provided. Double check that you are using the correct IDs.
      def check_status(merchant_id:, installation_id:, payment_session_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_session_id] = payment_session_id
        @real_client.check_status(**args)
      end

      # ## Discover the next action
      #
      # This endpoint guide you through the payment flow by telling you what action to take next.
      # You should poll this endpoint from your frontend to track the payment progress. We recommend polling
      # every 1-2 seconds.
      #
      # The possible responses are:
      #
      # - `WAIT`: The payment is not ready yet, continue polling
      # - `DISPLAY_QR`: Display a QR code to the customer
      # - `REDIRECT`: Redirect the customer to complete the payment
      # - `CHECK_STATUS`: The payment flow is complete, check the final status
      #
      # General implementation flow:
      #
      # 1. Start polling this endpoint after selecting a payment method
      # 2. When you receive an action (`DISPLAY_QR` or `REDIRECT`) take the appropriate action for your customer and continue polling in the background.
      # 3. When you receive `CHECK_STATUS` stop polling this endpoint and call `check-status` to see if payment succeeded.
      #
      # Implementation tips:
      #
      # - Use `setInterval()` or `setTimeout()` for polling from your frontend
      # - Add exponential backoff if you get multiple `WAIT` responses
      # - Handle network errors gracefully and retry failed requests
      # - Stop polling once you receive `CHECK_STATUS`
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or payment session with the IDs provided. Double check that you are using the correct IDs.
      def discover_next_action(merchant_id:, installation_id:, payment_session_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_session_id] = payment_session_id
        @real_client.discover_next_action(**args)
      end

      # ## Get the redirect URL
      #
      # This endpoint returns the URL where you should redirect your customer to complete their payment.
      # The URL is specific to the payment method that was selected.
      #
      # You should only call this endpoint after `discover-next-action` returns `REDIRECT`. The URL may not
      # be ready immediately after creating the payment session - in this case you'll receive a `NOT_READY`
      # error and should try again in a few seconds.
      #
      # After redirecting the customer, you should continue polling `discover-next-action` in the background
      # to know when they've completed the payment flow.
      #
      # Note: Not all payment methods require redirection. For methods that don't support redirection,
      # you'll receive a `NOT_SUPPORTED` error.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or payment session with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code NOT_READY - This error occurs when the redirect URL is not yet ready. Wait a few seconds and try again.
      # May raise WebFunction::BadRequestError with code NOT_SUPPORTED - This error occurs when trying to get a redirect URL for a payment method that doesn't support redirection (like QR codes).
      def get_redirect_url(merchant_id:, installation_id:, payment_session_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_session_id] = payment_session_id
        @real_client.get_redirect_url(**args)
      end

      # ## Get the return URL
      #
      # This endpoint returns the URL where you should redirect your customer after payment completed.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or payment session with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code NOT_READY - This error occurs when the redirect URL is not yet ready. Wait a few seconds and try again.
      def get_return_url(merchant_id:, installation_id:, payment_session_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_session_id] = payment_session_id
        @real_client.get_return_url(**args)
      end

      # ## List installment plans
      #
      # This endpoint returns the card installment plans available for a given amount and card.
      # Identify the card with either a `bin` (the leading digits of the card number) or a `token`
      # from `tokenize-card`.
      #
      # Eligibility depends on the card's BIN (issuing bank), the requested amount, the merchant's
      # installment configuration, and per-plan constraints (minimum amount, maximum amount, minimum
      # monthly amount). If no plans are eligible the endpoint returns an empty array; the client
      # should hide the installment step and proceed to `select-payment-method` without an
      # `installment_plan_id`.
      #
      # The amounts returned (`monthly_amount`, `total_amount`, `interest_amount`) are computed against
      # the amount you pass to this endpoint. Pass the same amount to `select-payment-method` to keep
      # the customer's quote consistent.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or card token with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code TOKEN_ALREADY_USED - This token has already been used to create a payment session. Each token can only be used once. Request a new token from `tokenize-card`.
      def list_installment_plans(merchant_id:, installation_id:, bin: Undefined, token: Undefined, amount:, currency:, interest_bearer: Undefined)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:bin] = bin unless bin.equal?(Undefined)
        args[:token] = token unless token.equal?(Undefined)
        args[:amount] = amount
        args[:currency] = currency
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        (@real_client.list_installment_plans(**args) || []).map { |item| InstallmentPlanAttributes.new(item) }
      end

      # ## Rehydrate a card security code
      #
      # This endpoint attaches a newly collected security code to a saved card's `token`, so the
      # token can be used for a customer-initiated payment (CIT). It returns the same `token`.
      #
      # The security code is never saved with the card. It covers only the payment made right
      # after it's entered, so every customer-initiated payment on a saved card needs a newly
      # entered security code:
      #
      # 1. Collect the security code from the customer.
      # 2. Call `rehydrate-card` with the saved card's `token` and the security code.
      # 3. Right after, call `select-payment-method` with the same `token` and start the payment.
      #
      # If the payment fails, collect the security code and call this endpoint again before
      # retrying.
      #
      # The browser SDK calls this endpoint for you in saved-card mode. Merchant-initiated payments
      # (MIT) through the merchant `request-payment` endpoint don't need it.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account with the IDs provided. Double check that you are using the correct IDs.
      def rehydrate_card(merchant_id:, security_code:, token:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:security_code] = security_code
        args[:token] = token
        @real_client.rehydrate_card(**args)
      end

      # ## Retrieve Checkout
      #
      # Retrieves a specific checkout by its ID for a given installation.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The merchant, installation, or checkout could not be found with the provided IDs.
      def retrieve_checkout(merchant_id:, installation_id:, checkout_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:checkout_id] = checkout_id
        (v = @real_client.retrieve_checkout(**args)) && RetrieveCheckoutResult.new(v)
      end

      # ## Retrieve the installation settings
      #
      # This endpoint allows you to retrieve the settings and configuration for a specific installation
      # (e.g. your iOS app, Android app, website, or terminal). The settings contain important information like
      # the supported payment methods and UI customization options.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account or installation with the IDs provided. Double check that you are using the correct IDs.
      def retrieve_installation_settings(merchant_id:, installation_id:, interest_bearer: Undefined)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        (v = @real_client.retrieve_installation_settings(**args)) && RetrieveInstallationSettingsResult.new(v)
      end

      # ## Retrieve payment link
      #
      # Retrieves a specific payment link by its ID for a given installation.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The merchant, installation, or payment link could not be found with the provided IDs.
      def retrieve_payment_link(merchant_id:, installation_id:, payment_link_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_link_id] = payment_link_id
        (v = @real_client.retrieve_payment_link(**args)) && RetrievePaymentLinkResult.new(v)
      end

      # ## Retrieve payment session
      #
      # Retrieves a payment session by its ID. Returns the payment session details including payment status, amount, currency, and reference numbers.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The payment session could not be found with the provided ID.
      def retrieve_payment_session(payment_session_id:)
        args = {}
        args[:payment_session_id] = payment_session_id
        (v = @real_client.retrieve_payment_session(**args)) && RetrievePaymentSessionResult.new(v)
      end

      # ## Retrieve the data to display a QR code
      #
      # This endpoint returns the data needed to display a QR code for payment methods that support QR-based payments (like PromptPay).
      #
      # You should only call this endpoint after `discover-next-action` returns `DISPLAY_QR`. The QR data may not be ready immediately
      # after creating the payment session - in this case you'll receive a `NOT_READY` error and should try again in a few seconds.
      #
      # After displaying the QR code to your customer, you should continue polling `check-status` in the background to know when
      # they've completed the payment by scanning the code.
      #
      # Note: Not all payment methods use QR codes. For methods that don't support QR codes, you'll receive a `NOT_SUPPORTED` error.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or payment session with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code NOT_READY - This error occurs when the QR data is not yet ready. Wait a few seconds and try again.
      # May raise WebFunction::BadRequestError with code NOT_SUPPORTED - This error occurs when trying to get QR data for a payment method that doesn't support QR codes.
      def retrieve_qr_data(merchant_id:, installation_id:, payment_session_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:payment_session_id] = payment_session_id
        @real_client.retrieve_qr_data(**args)
      end

      # ## Select payment method
      #
      # This endpoint creates a new payment session with the customer's chosen payment method.
      # It returns a payment session ID that you'll use in subsequent API calls to complete the payment flow.
      #
      # The flow after calling this endpoint depends on the selected payment method:
      #
      # - For card payments: You must provide a card token obtained from `tokenize-card`, or a
      #   saved card's token right after `rehydrate-card`
      # - For QR code payments: Call `retrieve-qr-data` to get the QR code data to display
      # - For redirect-based payments: Call `get-redirect-url` to get the URL to redirect the customer to
      #
      # Card installments:
      #
      # To charge a card in monthly installments instead of a single payment, pass an
      # `installment_plan_id` obtained from `list-installment-plans`. The `amount` and `currency`
      # must match the values you passed to `list-installment-plans`, and the card you tokenize
      # must be the card whose BIN (or token) you used there, so the chosen plan stays eligible
      # and the customer's quote remains consistent. Omit `installment_plan_id` to charge the card
      # as a one-time payment.
      #
      # Billing-address fields are routed according to the setting that requires them:
      #
      # | Configuration | Address destination | Required fields |
      # | --- | --- | --- |
      # | Card payment method `requires_address: true` | `tokenize-card` | The card payment method's `required_fields` |
      # | Installation `address_capture: required` | `select-payment-method` | The selected payment method's `required_fields` |
      #
      # Address fields required by the selected payment method must be submitted to this endpoint.
      # An empty `required_fields` configuration uses the default full address consisting of
      # `street_address_1`, `postal_code`, `city`, `state`, and `country`; `street_address_2` is
      # always optional.
      #
      # After starting the payment flow, you should poll `discover-next-action` to track the payment status
      # and determine the next steps.
      # May raise WebFunction::BadRequestError with code INVALID_ARGUMENTS - This error occurs when the request contains invalid or missing parameters. Common cases include: - A missing `merchant_id`, `installation_id`, `amount`, `currency`, or `payment_method` - An unsupported `currency` (must match the funding currency configured for your provider) - An installation that could not be found or does not have the requested payment method enabled - Missing customer email or mobile when required by the installation - Missing address fields when required by the installation and payment method
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account, installation, or card token with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code TOKEN_ALREADY_USED - This single-use token has already been used to create a payment session. Each single-use token can only be used once. Request a new token from `tokenize-card`.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - This installation is currently disabled.
      # May raise WebFunction::BadRequestError with code INSTALLMENT_NOT_ELIGIBLE - The installment plan you provided is not eligible for this payment, for example because the card, amount, or interest bearer does not match the plan, or the plan is no longer offered.
      def select_payment_method(merchant_id:, installation_id:, installment_plan_id: Undefined, amount:, currency:, payment_method:, token: Undefined, customer_email: Undefined, customer_mobile: Undefined, customer_name: Undefined, customer_language: Undefined, interest_bearer: Undefined, street_address_1: Undefined, street_address_2: Undefined, postal_code: Undefined, city: Undefined, state: Undefined, country: Undefined)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:installment_plan_id] = installment_plan_id unless installment_plan_id.equal?(Undefined)
        args[:amount] = amount
        args[:currency] = currency
        args[:payment_method] = payment_method
        args[:token] = token unless token.equal?(Undefined)
        args[:customer_email] = customer_email unless customer_email.equal?(Undefined)
        args[:customer_mobile] = customer_mobile unless customer_mobile.equal?(Undefined)
        args[:customer_name] = customer_name unless customer_name.equal?(Undefined)
        args[:customer_language] = customer_language unless customer_language.equal?(Undefined)
        args[:interest_bearer] = interest_bearer unless interest_bearer.equal?(Undefined)
        args[:street_address_1] = street_address_1 unless street_address_1.equal?(Undefined)
        args[:street_address_2] = street_address_2 unless street_address_2.equal?(Undefined)
        args[:postal_code] = postal_code unless postal_code.equal?(Undefined)
        args[:city] = city unless city.equal?(Undefined)
        args[:state] = state unless state.equal?(Undefined)
        args[:country] = country unless country.equal?(Undefined)
        @real_client.select_payment_method(**args)
      end

      # ## Tokenize a card number
      #
      # This endpoint securely converts sensitive card details into a token that can be safely
      # stored and used for future payments. The token can be used with the
      # `select-payment-method` endpoint to process card payments.
      #
      # The tokenization process helps you maintain PCI compliance by avoiding the need to
      # handle raw card data directly in your systems. The token can only be used with your
      # merchant account and cannot be used to process payments elsewhere.
      #
      # For security reasons, tokens are single-use by default. To save the card to a contact for
      # later payments, set usage to `MULTIPLE` when creating the token.
      #
      # The security code is never saved with the card. It covers only the payment made right
      # after tokenization, so use the token right away. For a later customer-initiated payment on
      # a saved card, collect the security code again and call `rehydrate-card` right before
      # `select-payment-method`. To charge a saved card from your backend without the security
      # code (a merchant-initiated payment), use the merchant `request-payment` endpoint instead.
      #
      # Billing-address fields are routed according to the setting that requires them:
      #
      # | Configuration | Address destination | Required fields |
      # | --- | --- | --- |
      # | Card payment method `requires_address: true` | `tokenize-card` | The card payment method's `required_fields` |
      # | Installation `address_capture: required` | `select-payment-method` | The selected payment method's `required_fields` |
      #
      # This endpoint validates only the card payment method's address requirement. Installation
      # address capture is validated by `select-payment-method`. `street_address_2` is always
      # optional.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - This error occurs when we cannot find the merchant account or installation with the IDs provided. Double check that you are using the correct IDs.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - This installation is currently disabled.
      def tokenize_card(merchant_id:, installation_id:, number:, name:, expiration_date:, security_code:, usage: Undefined, payment_method: Undefined, street_address_1: Undefined, street_address_2: Undefined, postal_code: Undefined, city: Undefined, state: Undefined, country: Undefined)
        args = {}
        args[:merchant_id] = merchant_id
        args[:installation_id] = installation_id
        args[:number] = number
        args[:name] = name
        args[:expiration_date] = expiration_date
        args[:security_code] = security_code
        args[:usage] = usage unless usage.equal?(Undefined)
        args[:payment_method] = payment_method unless payment_method.equal?(Undefined)
        args[:street_address_1] = street_address_1 unless street_address_1.equal?(Undefined)
        args[:street_address_2] = street_address_2 unless street_address_2.equal?(Undefined)
        args[:postal_code] = postal_code unless postal_code.equal?(Undefined)
        args[:city] = city unless city.equal?(Undefined)
        args[:state] = state unless state.equal?(Undefined)
        args[:country] = country unless country.equal?(Undefined)
        @real_client.tokenize_card(**args)
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
