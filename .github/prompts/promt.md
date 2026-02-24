---
mode: Agent
---
# 任务

1.成功部署 OptimisticOracleV2 合约到测试网
2.涉及到的所有合约部署在测试网的地址输出一个MD文档

# 要求

OptimisticOracleV2 依赖的所有合约都在项目中 要识别 诸如 Finder Timer合约
所有合约的owner私钥0x92a23b579cfc51fb9579dfb9aadd9ceb03832216f2e96ede1cbf623ab20e3778
因为本机是windows中wsl系统需要使用代理：PROXY_URL=http://172.27.48.1:7897 
RPC_URL=https://eth-sepolia.g.alchemy.com/v2/_niqlVIZ45oFIb8ecXlDv
ETHERSCAN_API_KEY=23SKP615853RP1WAH3P3EDQM1I5U2RITKE
# 成功标准

可以使用0xD824c881881407911FcdDF532aC4aC78B24120b0用户 完成 OptimisticOracleV2 所有方法的调用且全部通过