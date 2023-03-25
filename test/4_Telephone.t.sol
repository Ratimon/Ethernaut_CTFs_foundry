// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test} from "@forge-std/Test.sol";

import {DeployTelephoneScript} from "@script/4_DeployTelephone.s.sol";

import {Telephone} from "@main/4_Telephone.sol";
import {TelephoneAttacker} from "@main/4_TelephoneAttacker.sol";


contract FallbackTest is Test, DeployTelephoneScript {

    address public deployer;
    address public attacker = address(11);

    TelephoneAttacker telephoneAttacker;

    function setUp() public {

        deployer = msg.sender;

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        DeployTelephoneScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        telephoneAttacker = new TelephoneAttacker(address(telephoneChallenge));
        telephoneAttacker.attack();
        assertEq( telephoneChallenge.owner(), attacker);
       
        vm.stopPrank(  );
    }



}