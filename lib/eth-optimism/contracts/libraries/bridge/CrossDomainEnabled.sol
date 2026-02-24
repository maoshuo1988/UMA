// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ICrossDomainMessenger.sol";

contract CrossDomainEnabled {
    address public messenger;

    constructor(address _messenger) {
        messenger = _messenger;
    }

    modifier onlyFromCrossDomainAccount(address) {
        _;
    }

    function sendCrossDomainMessage(address _dest, uint32 _gasLimit, bytes memory _message) internal virtual {
        // no-op stub
        ICrossDomainMessenger(messenger).sendMessage(_dest, _message, _gasLimit);
    }
}
