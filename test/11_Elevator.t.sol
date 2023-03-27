// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployElevatorScript} from "@script/11_DeployElevator.s.sol";
// import {DeployElevatorAttackerScript} from "@script/11_DeployElevatorAttacker.s.sol";

import {Elevator} from "@main/11_Elevator.sol";
import {ElevatorAttacker} from "@main/11_ElevatorAttacker.sol";


contract FallbackTest is Test, DeployElevatorScript {

    address public deployer;
    address public attacker = address(11);

    ElevatorAttacker elevatorAttacker;

    function setUp() public {

        deployer = msg.sender;

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        vm.label(deployer, "Deployer");
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