// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployForceScript} from "@script/7_DeployForce.s.sol";

import {Force} from "@main/7_Force.sol";
import {ForceAttacker} from "@main/7_ForceAttacker.sol";

contract ForceTest is Test, DeployForceScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    ForceAttacker forceAttacker;

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 2 ether);

        DeployForceScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq(address(forceChallenge).balance, 0);
        forceAttacker = new ForceAttacker{value : 1 ether}(address(forceChallenge));
        forceAttacker.attack();
        assertGt(address(forceChallenge).balance, 1);

        vm.stopPrank();
    }
}
