// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import {Finder} from "src/data-verification-mechanism/implementation/Finder.sol";
import {Store} from "src/data-verification-mechanism/implementation/Store.sol";
import {IdentifierWhitelist} from "src/data-verification-mechanism/implementation/IdentifierWhitelist.sol";
import {AddressWhitelist} from "src/common/implementation/AddressWhitelist.sol";
import {Registry} from "src/data-verification-mechanism/implementation/Registry.sol";
import {FixedPoint} from "src/common/implementation/FixedPoint.sol";
import {OptimisticOracleV2} from "src/optimistic-oracle-v2/implementation/OptimisticOracleV2.sol";
import {SkinnyOptimisticOracleV2} from "src/optimistic-oracle-v2/implementation/SkinnyOptimisticOracleV2.sol";
// 如需 VotingV2 全套，再补充 import VotingToken/VotingV2/DesignatedVotingV2Factory/GovernorV2/ProposerV2/EmergencyProposer/FixedSlashSlashingLibrary 等

contract DeployFull is Script {
    function run() external {
        uint256 pk = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(pk);

        Finder finder = new Finder();
        IdentifierWhitelist idW = new IdentifierWhitelist();
        AddressWhitelist colW = new AddressWhitelist();
        Store store = new Store(FixedPoint.Unsigned(0), FixedPoint.Unsigned(0), address(0)); // live 网络 Timer=0x0

        // 根据需要：在 finder 填写接口映射（IdentifierWhitelist/CollateralWhitelist/Store/Oracle 等）
        finder.changeImplementationAddress(keccak256("IdentifierWhitelist"), address(idW));
        finder.changeImplementationAddress(keccak256("CollateralWhitelist"), address(colW));
        finder.changeImplementationAddress(keccak256("Store"), address(store));
        // Oracle 接口可先指向占位，后续再更新
        // finder.changeImplementationAddress(keccak256("Oracle"), <oracleAddr>);

        OptimisticOracleV2 oo = new OptimisticOracleV2(7200, address(finder), address(0));
        SkinnyOptimisticOracleV2 soo = new SkinnyOptimisticOracleV2(7200, address(finder), address(0));

        // 如需进一步：部署 VotingToken/VotingV2/DesignatedVotingV2Factory/GovernorV2/ProposerV2/EmergencyProposer 并写入 Finder/Registry

        vm.stopBroadcast();

        console2.log("Finder", address(finder));
        console2.log("IdentifierWhitelist", address(idW));
        console2.log("AddressWhitelist", address(colW));
        console2.log("Store", address(store));
        console2.log("OptimisticOracleV2", address(oo));
        console2.log("SkinnyOptimisticOracleV2", address(soo));
    }
}
