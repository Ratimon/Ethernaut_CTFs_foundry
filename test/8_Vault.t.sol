// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployVaultScript} from "@script/8_DeployVault.s.sol";

import {Vault} from "@main/8_Vault.sol";

contract VaultTest is Test, DeployVaultScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    function setUp() public {
        vm.label(attacker, "Attacker");
        DeployVaultScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);
        
        assertEq(vaultChallenge.locked(), true);
        bytes32 password = vm.load(address(vaultChallenge), bytes32(uint256(1)));
        vaultChallenge.unlock(password);
        assertEq(vaultChallenge.locked(), false);
        vm.stopPrank(  );
    }

}