// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployTelephoneScript} from "@script/4_DeployTelephone.s.sol";

import {Telephone} from "@main/4_Telephone.sol";
import {TelephoneAttacker} from "@main/4_TelephoneAttacker.sol";


contract FallbackTest is Test, DeployTelephoneScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    TelephoneAttacker telephoneAttacker;

    function setUp() public {

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        DeployTelephoneScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);
        
        assertEq( telephoneChallenge.owner(), deployer);
        telephoneAttacker = new TelephoneAttacker(address(telephoneChallenge));
        telephoneAttacker.attack();
        assertEq( telephoneChallenge.owner(), attacker);
       
        vm.stopPrank(  );
    }

}