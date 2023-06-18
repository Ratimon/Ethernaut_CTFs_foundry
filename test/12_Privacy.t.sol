// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployPrivacyScript} from "@script/12_DeployPrivacy.s.sol";

import {Privacy} from "@main/12_Privacy.sol";

contract PrivacyTest is Test, DeployPrivacyScript {
    address public attacker = address(11);

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 1 ether);

        DeployPrivacyScript.run();
    }

    function test_isSolved() public {
        vm.startPrank(attacker);
        assertEq(privacyChallenge.locked(), true);

        bytes32 secret = vm.load(address(privacyChallenge), bytes32(uint256(5))); // slot 5
        emit log_bytes32(secret);
        privacyChallenge.unlock(bytes16(secret));

        assertEq(privacyChallenge.locked(), false);
        vm.stopPrank();
    }
}
