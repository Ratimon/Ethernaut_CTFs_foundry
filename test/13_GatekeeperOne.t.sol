// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployGatekeeperOneScript} from "@script/13_DeployGatekeeperOne.s.sol";

import {GatekeeperOne} from "@main/13_GatekeeperOne.sol";
import {GatekeeperOneAttacker} from "@main/13_GatekeeperOneAttacker.sol";

contract GatekeeperOneTest is Test, DeployGatekeeperOneScript {
    string mnemonic = "test test test test test test test test test test test junk";
    uint256 attackerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 2); //  address = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC

    address attacker = vm.addr(attackerPrivateKey);

    GatekeeperOneAttacker gatekeeperoneAttacker;

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 1 ether);

        DeployGatekeeperOneScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker, attacker);

        assertEq(gatekeeperoneChallenge.entrant(), address(0));

        gatekeeperoneAttacker = new GatekeeperOneAttacker(address(gatekeeperoneChallenge));

        bytes8 key = bytes8(uint64(uint160(attacker))) & 0xFFFFFFFF0000FFFF;
        gatekeeperoneAttacker.attack(key);
        assertEq(gatekeeperoneChallenge.entrant(), attacker);

        vm.stopPrank();
    }
}
