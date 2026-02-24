#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# 加载上级目录 .env（需包含 ETHERSCAN_API_KEY、RPC_URL、Finder 等地址变量）
if [ -f ../../.env ]; then
  set -a
  source ../../.env
  set +a
else
  echo "../../.env 未找到" >&2
  exit 1
fi

: "${ETHERSCAN_API_KEY:?缺少 ETHERSCAN_API_KEY}"
: "${RPC_URL:?缺少 RPC_URL}"
: "${Finder:?缺少 Finder 地址}"
: "${IdentifierWhitelist:?缺少 IdentifierWhitelist 地址}"
: "${AddressWhitelist:?缺少 AddressWhitelist 地址}"
: "${Store:?缺少 Store 地址}"
: "${OptimisticOracleV2:?缺少 OptimisticOracleV2 地址}"
: "${SkinnyOptimisticOracleV2:?缺少 SkinnyOptimisticOracleV2 地址}"

# 代理可选
: "${ALL_PROXY:=}"
: "${https_proxy:=}"
: "${HTTP_PROXY:=}"

CHAIN=11155111
VERIFIER=https://api-sepolia.etherscan.io/api
SOLC=0.8.16
RUNS=1000000

# 构造参数动态编码
STORE_ARGS=$(cast abi-encode "constructor((uint256),(uint256),address)" '(0)' '(0)' 0x0000000000000000000000000000000000000000)
OO_ARGS=$(cast abi-encode "constructor(uint256,address,address)" 7200 "$Finder" 0x0000000000000000000000000000000000000000)

verify() {
  local addr=$1
  local path=$2
  local name=$3
  local ctor=${4:-}
  local etherscan_key
  etherscan_key="${ETHERSCAN_SEPOLIA_API_KEY:-${ETHERSCAN_API_KEY:-}}"
  if [[ -z "$etherscan_key" ]]; then
    echo "[error] VERIFIER=etherscan 需要 ETHERSCAN_SEPOLIA_API_KEY 或 ETHERSCAN_API_KEY" >&2
    exit 1
  fi
  if [ -n "$ctor" ]; then
    forge verify-contract "$addr" "$path":"$name" \
      --chain $CHAIN --verifier etherscan \
      --etherscan-api-key "$etherscan_key" \
      --constructor-args "$ctor" \
      --num-of-optimizations $RUNS --compiler-version $SOLC --retries 2 --delay 5
  else
    forge verify-contract "$addr" "$path":"$name" \
      --chain $CHAIN --verifier etherscan \
      --etherscan-api-key "$etherscan_key" \
      --num-of-optimizations $RUNS --compiler-version $SOLC --retries 2 --delay 5
  fi
}

verify "$Finder" src/data-verification-mechanism/implementation/Finder.sol Finder
verify "$IdentifierWhitelist" src/data-verification-mechanism/implementation/IdentifierWhitelist.sol IdentifierWhitelist
verify "$AddressWhitelist" src/common/implementation/AddressWhitelist.sol AddressWhitelist
verify "$Store" src/data-verification-mechanism/implementation/Store.sol Store "$STORE_ARGS"
verify "$OptimisticOracleV2" src/optimistic-oracle-v2/implementation/OptimisticOracleV2.sol OptimisticOracleV2 "$OO_ARGS"
verify "$SkinnyOptimisticOracleV2" src/optimistic-oracle-v2/implementation/SkinnyOptimisticOracleV2.sol SkinnyOptimisticOracleV2 "$OO_ARGS"
