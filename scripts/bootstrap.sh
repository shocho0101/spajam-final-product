# !/bin/sh

if ! which mint >/dev/null; then
    brew install mint    
fi
mint bootstrap
mint run xcodegen