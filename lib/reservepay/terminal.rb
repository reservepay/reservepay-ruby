# Generated client for the Reservepay Terminal API webfunction package.
# Source: https://api.reservepay.com/terminals
#
# Wraps the real web_function gem (github.com/robinclart/web_function) -
# every method here calls straight through to the real dynamic client.
# frozen_string_literal: true

require "web_function"

module Reservepay
  module Terminal
    class ConnectDeviceByCodeResult
      def initialize(raw)
        @raw = raw
      end

      # The merchant ID this terminal belongs to.
      def merchant_id
        @raw["merchant_id"]
      end

      # Terminal ID (`trm_…`) the device is connected to.
      def terminal_id
        @raw["terminal_id"]
      end

      # API key token for this device, prefixed with `reservepay_`.
      def key
        @raw["key"]
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

      # Display name of the terminal that requested these settings.
      def terminal_name
        @raw["terminal_name"]
      end

      # Branch name configured on the terminal, if any.
      def terminal_branch_name
        @raw["terminal_branch_name"]
      end

      # Whether the terminal is in kiosk mode.
      def terminal_kiosk_mode
        @raw["terminal_kiosk_mode"]
      end

    end

    # Sentinel distinguishing "caller omitted this optional argument" from
    # "caller explicitly passed nil" - forwarding nil either way would send
    # the real client (and the real server) an explicit JSON null for an
    # argument that was never actually given.
    Undefined = ::Object.new.freeze

    class Client
      # The package endpoint this client was generated from.
      SOURCE_URL = "https://api.reservepay.com/terminals"

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

      # ## Connect a device to a terminal
      #
      # Connect a device to a terminal instance. If the terminal has no device bound,
      # this will bind the provided `device_id` and generate a fresh API key token
      # (prefixed with `reservepay_`). If the terminal is already bound to the same
      # `device_id`, the previous key is revoked and a new one is issued.
      #
      # If the terminal is bound to a different device, an `ALREADY_CONNECTED` error
      # is returned.
      #
      # If the terminal is disabled, `NOT_ENABLED` is returned.
      #
      # If the terminal has no installation linked, `NOT_CONFIGURED` is returned.
      # May raise WebFunction::BadRequestError with code ALREADY_CONNECTED - The terminal is connected to another device.
      # May raise WebFunction::BadRequestError with code INVALID_CHALLENGE - The challenge is missing or does not match the terminal's current challenge.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - Merchant or terminal could not be found.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - The terminal exists but is disabled; enable it before connecting a device.
      # May raise WebFunction::BadRequestError with code NOT_CONFIGURED - The terminal has no installation linked; assign an installation first.
      def connect_device(merchant_id:, terminal_id:, device_id:, challenge: Undefined)
        args = {}
        args[:merchant_id] = merchant_id
        args[:terminal_id] = terminal_id
        args[:device_id] = device_id
        args[:challenge] = challenge unless challenge.equal?(Undefined)
        @real_client.connect_device(**args)
      end

      # ## Connect a device with a temporary challenge
      #
      # Connect a device to the terminal that owns the given 8-digit temporary challenge.
      # The code must be unexpired. On success the device is bound, the temporary challenge
      # is cleared, and the response holds the merchant ID, the terminal ID and a fresh API
      # key token (prefixed with `reservepay_`).
      #
      # If the terminal is already bound to a different device, `ALREADY_CONNECTED` is returned.
      # If it is bound to the same device, the previous key is revoked and a new one is issued.
      #
      # If the terminal is disabled, `NOT_ENABLED` is returned.
      #
      # If the terminal has no installation linked, `NOT_CONFIGURED` is returned.
      # May raise WebFunction::BadRequestError with code ALREADY_CONNECTED - The terminal is connected to another device.
      # May raise WebFunction::BadRequestError with code INVALID_CHALLENGE - The code is unknown or has expired.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - The terminal exists but is disabled; enable it before connecting a device.
      # May raise WebFunction::BadRequestError with code NOT_CONFIGURED - The terminal has no installation linked; assign an installation first.
      def connect_device_by_code(code:, device_id:)
        args = {}
        args[:code] = code
        args[:device_id] = device_id
        (v = @real_client.connect_device_by_code(**args)) && ConnectDeviceByCodeResult.new(v)
      end

      # ## Retrieve the installation settings
      #
      # Returns settings and configuration for the installation linked to the terminal
      # (payment methods, UI options, etc.), after verifying the bound device.
      #
      # The terminal must be connected via `connect-device` and must have an installation
      # configured on the merchant terminal record.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - The merchant or terminal could not be found, or no device is bound to the terminal.
      # May raise WebFunction::BadRequestError with code UNRECOGNIZED_DEVICE - The device_id does not match the one bound to the terminal.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - The terminal exists but is disabled.
      # May raise WebFunction::BadRequestError with code NOT_CONFIGURED - The terminal has no installation linked; assign an installation to the terminal first.
      def retrieve_installation_settings(merchant_id:, terminal_id:, device_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:terminal_id] = terminal_id
        args[:device_id] = device_id
        (v = @real_client.retrieve_installation_settings(**args)) && RetrieveInstallationSettingsResult.new(v)
      end

      # ## Verify connection
      #
      # Verifies the connection between a physical device and a terminal.
      #
      # Returns one of:
      # - `CONNECTED` when the provided device is bound to the terminal
      # - `RESET_CONNECTION` when no device is bound (erase keys/PIN and call `connect-device`)
      #
      # If no device is bound, you should call the [connect-device](/api/terminals/connect-device) endpoint.
      #
      # Errors:
      # - `UNRECOGNIZED_DEVICE` if another device is currently bound
      # - `NOT_FOUND` if the merchant or terminal cannot be found
      # - `NOT_ENABLED` if the terminal is disabled
      # - `NOT_CONFIGURED` if the terminal has no installation linked
      # May raise WebFunction::BadRequestError with code UNRECOGNIZED_DEVICE - The device_id does not match the one bound to the terminal.
      # May raise WebFunction::BadRequestError with code NOT_FOUND - Merchant or terminal could not be found.
      # May raise WebFunction::BadRequestError with code NOT_ENABLED - The terminal exists but is disabled.
      # May raise WebFunction::BadRequestError with code NOT_CONFIGURED - The terminal has no installation linked; assign an installation first.
      def verify_connection(merchant_id:, terminal_id:, device_id:)
        args = {}
        args[:merchant_id] = merchant_id
        args[:terminal_id] = terminal_id
        args[:device_id] = device_id
        @real_client.verify_connection(**args)
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
