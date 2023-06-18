// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployDenialScript} from "@script/20_DeployDenial.s.sol";

import {Denial} from "@main/20_Denial.sol";
import {DenialAttacker} from "@main/20_DenialAttacker.sol";

interface IDenial {
    function owner() external;
}

contract DenialTest is Test, DeployDenialScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

    address deployer = vm.addr(deployerPrivateKey);
    address attacker = vm.addr(attackerPrivateKey);

    address player = address(12);

    DenialAttacker denialAttacker;

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");
        vm.label(player, "Player");

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 2 ether);
        vm.deal(player, 3 ether);

        DeployDenialScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq(address(IDenial(address(denialChallenge))).balance, 1 ether);
        denialAttacker = new DenialAttacker(payable(address(denialChallenge)));
        uint256 gas_start = gasleft();
        // vm.expectRevert();
        denialAttacker.attack();
        uint256 gas_used = gas_start - gasleft();
        emit log_named_uint("Gas Metering", gas_used);
        // assertEq( address(IDenial(address(denialChallenge))).balance, 0.99 ether);

        vm.stopPrank();
    }
}
