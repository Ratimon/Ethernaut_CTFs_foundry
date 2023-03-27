// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {Test} from "@forge-std/Test.sol";

import {DeployFalloutScript} from "@script-0_6_x/2_DeployFallout.s.sol";
import {Fallout} from "@main-0_6_x/2_Fallout.sol";

contract FalloutTest is Test, DeployFalloutScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    function setUp() public {

        vm.deal(attacker, 1 ether);
        vm.label(attacker, "Attacker");

        DeployFalloutScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq( falloutChallenge.owner(), address(0));
        falloutChallenge.Fal1out{value: 0.0005 ether}();
        assertEq( falloutChallenge.owner(), attacker);
       
        vm.stopPrank(  );
    }

}