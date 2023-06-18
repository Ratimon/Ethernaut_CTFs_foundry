// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployKingScript} from "@script/9_DeployKing.s.sol";

import {King} from "@main/9_King.sol";
import {KingAttacker} from "@main/9_KingAttacker.sol";

contract KingTest is Test, DeployKingScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
    uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

    address deployer = vm.addr(deployerPrivateKey);
    address attacker = vm.addr(attackerPrivateKey);

    address player = address(12);

    KingAttacker kingAttacker;

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");
        vm.label(player, "Player");

        vm.deal(deployer, 1 ether);
        vm.deal(attacker, 2 ether);
        vm.deal(player, 3 ether);

        DeployKingScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        kingAttacker = new KingAttacker(address(kingChallenge));
        kingAttacker.attack{value: 2 ether}();

        vm.stopPrank();
        vm.startPrank(player);

        vm.expectRevert();
        address(kingChallenge).call{value: 3 ether}("");

        vm.stopPrank();
    }
}
