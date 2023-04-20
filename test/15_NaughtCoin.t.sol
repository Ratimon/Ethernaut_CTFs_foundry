// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployNaughtCoinScript} from "@script/15_DeployNaughtCoin.s.sol";

import {NaughtCoin} from "@main/15_NaughtCoin.sol";
import {NaughtCoinAttacker} from "@main/15_NaughtCoinAttacker.sol";

contract NaughtCoinTest is Test, DeployNaughtCoinScript {

    address public deployer;

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
    address attacker = vm.addr(attackerPrivateKey);

    uint256 recipientPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 3); // 
    address recipient =vm.addr(recipientPrivateKey);

    NaughtCoinAttacker naughtCoinAttacker;

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 1 ether);
        

        DeployNaughtCoinScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq( naughtcoinChallenge.balanceOf(attacker), 1_000_000 ether);
        assertEq( naughtcoinChallenge.balanceOf(recipient), 0 ether);

        naughtCoinAttacker = new NaughtCoinAttacker(address(naughtcoinChallenge), recipient);
        naughtcoinChallenge.approve(address(naughtCoinAttacker),type(uint256).max);
        naughtCoinAttacker.attack();

        assertEq( naughtcoinChallenge.balanceOf(attacker), 0 ether);
        assertEq( naughtcoinChallenge.balanceOf(recipient), 1_000_000 ether);

        vm.stopPrank(  );
    }

}