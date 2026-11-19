#!/usr/bin/env bash
set -euo pipefail

# Path to the wfn executable; override with the WFN_PATH env var
WFN="${WFN_PATH:-wfn}"

# Check wfn exists
if ! command -v "$WFN" >/dev/null 2>&1; then
  echo "Error: '$WFN' WebFunction CLI tool was not found in your PATH." >&2
  echo "You can specify its location using the WFN_PATH environment variable, e.g.:" >&2
  echo "  WFN_PATH=/path/to/wfn $0" >&2
  echo "If you don't have the tool, get/build it from https://github.com/webfunction-protocol/webfunction-cli" >&2
  exit 1
fi

mkdir -p lib/reservepay sig/reservepay

# Set the copyright year in the license to the current year
sed "s/^Copyright (c) [0-9]\{4\}/Copyright (c) $(date +%Y)/" LICENSE.txt > LICENSE.txt.tmp
mv LICENSE.txt.tmp LICENSE.txt

# Generate code for clients (each API is its own Ruby module). Each run writes a .rb file and a
# .rbs type signature file next to it
"$WFN" codegen --target ruby --url https://api.reservepay.com/merchants -o ./lib/reservepay/merchant.rb --namespace Reservepay::Merchant
"$WFN" codegen --target ruby --url https://api.reservepay.com/terminals -o ./lib/reservepay/terminal.rb --namespace Reservepay::Terminal
"$WFN" codegen --target ruby --url https://api.reservepay.com/sdk -o ./lib/reservepay/sdk.rb --namespace Reservepay::SDK

# Move the type signatures to sig/, where RBS and Steep (and the gem) expect them
mv lib/reservepay/*.rbs sig/reservepay/

# Check the generated clients load (needs Ruby and Bundler)
if command -v bundle >/dev/null 2>&1; then
  bundle install --quiet
  bundle exec ruby -Ilib -e 'require "reservepay"'
  echo "Clients generated and 'require \"reservepay\"' passed"
else
  echo "Install Ruby and Bundler, then run 'bundle install' to check the generated clients load"
fi
