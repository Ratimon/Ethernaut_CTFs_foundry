// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployElevatorScript} from "@script/11_DeployElevator.s.sol";

import {Elevator} from "@main/11_Elevator.sol";
import {ElevatorAttacker} from "@main/11_ElevatorAttacker.sol";

contract ElevatorTest is Test, DeployElevatorScript {

    address public attacker = address(11);
    ElevatorAttacker elevatorAttacker;

    function setUp() public {

        vm.deal(attacker, 1 ether);
        vm.label(attacker, "Attacker");

        DeployElevatorScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq( elevatorChallenge.top(), false);
        elevatorAttacker = new ElevatorAttacker(address(elevatorChallenge));
        elevatorAttacker.attack(10);
        assertEq( elevatorChallenge.top(), true);
       
        vm.stopPrank(  );
    }

}