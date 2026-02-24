// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

library Enum {
    enum Operation { Call, DelegateCall }
}

abstract contract Module {
    address public owner;
    address public avatar;
    address public target;

    modifier initializer() { _; }
    modifier onlyOwner() { _; }

    function __Ownable_init() internal virtual { owner = msg.sender; }

    function exec(address to, uint256 value, bytes memory data, Enum.Operation) public virtual returns (bool success) {
        (success, ) = to.call{value: value}(data);
    }

    function setAvatar(address _avatar) public virtual {
        avatar = _avatar;
    }

    function setTarget(address _target) public virtual {
        target = _target;
    }

    function transferOwnership(address newOwner) public virtual {
        owner = newOwner;
    }

    function setUp(bytes memory) public virtual initializer {}
}
