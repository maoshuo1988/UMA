# OptimisticOracleV2 部署（Sepolia）

## 环境
- RPC: https://eth-sepolia.g.alchemy.com/v2/_niqlVIZ45oFIb8ecXlDv
- Proxy: http://172.27.48.1:7897
- PrivateKey (owner): 0x92a23b579cfc51fb9579dfb9aadd9ceb03832216f2e96ede1cbf623ab20e3778
- Foundry: `forge script script/DeployFull.s.sol:DeployFull --rpc-url ... --broadcast --verify --verifier etherscan --verifier-url https://api-sepolia.etherscan.io/api --gas-price 3000000000`

## 部署结果
- Finder: `0xf14cB09CC76ab7B404a5b1ec0599Bf5Fd1DAa3Ed`
- IdentifierWhitelist: `0xA6Fe153cBD2E969Ef878ADd52A9AB652585A8fc0`
- AddressWhitelist: `0x02EbEcd0afAC499558dc46F0eA57f58235d370bE`
- Store: `0x084a49C2c1a3bD4af09cFdA06BfD6d0067C567b8`
- OptimisticOracleV2: `0x925F932944BFB5CB172fD36a1b7aE702A906Df98`
- SkinnyOptimisticOracleV2: `0x20cB92B9343640cC673966D7Fc94EDFA7548f439`

