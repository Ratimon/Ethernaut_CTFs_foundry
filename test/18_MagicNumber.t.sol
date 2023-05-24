// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Test} from "@forge-std/Test.sol";
import {DeployMagicNumberScript} from "@script/18_MagicNumber.s.sol";

import {MagicNum} from "@main/18_MagicNumber.sol";

interface Solver {
  function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumberTest is Test, DeployMagicNumberScript {

    address public attacker = address(11);

    function setUp() public {
        vm.label(attacker, "Attacker");
        vm.deal(attacker, 1 ether);
        
        DeployMagicNumberScript.run();
    }

    function test_isSolved() public {

        vm.startPrank(attacker);

        // Runtime code

        // [00] PUSH1   2a --> 0x602A
        // [02] PUSH1   00 --> 0x6000
        // [04] MSTORE     --> 0x52 (Store value p=0x2a at position v=0x00 in memory)

        // [05] PUSH1   20 --> 0x6020 (32 bytes)
        // [07] PUSH1   00 --> 0x6000 (Value was stored in slot 0x80)
        // [09] RETURN     --> 0xF3 (Return value at p=0x00 slot and of size s=0x20)

        // => 602A60005260206000F3

        // Init code

        // [00] PUSH1   0a --> 0x600A (10 bytes)
        // [02] PUSH1   ?? --> 0x60?? 
        // [04] PUSH1   00 --> 0x6000
        // [06] CODECOPY   --> 0x39 (Calling the CODECOPY(t, f, s) 

        // - t: The destination offset where the code will be in memory
        // - f: This is the current position of the runtime opcode
        // - s: the size of the runtime code in bytes

        // [07] PUSH1   0A --> 0x600A (10 bytes)
        // [09] PUSH1   00 --> 0x6000 (Value was stored in slot 0x00)
        // [11] RETURN     --> 0xF3 (Return value at p=0x00 slot and of size s=0x0a)

        // => 0x600A60??600039600A6000F3
        // => 0x600a600C600039600A6000F3 (// [02] PUSH1   12 --> 0x600c )

        // Init code + Runtime code

        // 600a600C600039600A6000F3 + 602A60005260206000F3
        // => 600a600C600039600A6000F3602A60005260206000F3


        address deployedContractAddress;
        // bytes memory code = hex"69602A60005260206000F3600052600A6016F3";
        // bytes memory code = hex"600a600C600039600A6000F3602A60805260206080F3";

        bytes memory code = hex"600a600C600039600A6000F3602A60005260206000F3";

        assembly {
            deployedContractAddress := create(0, add(code, 0x20), mload(code))
        }
        magicnumberChallenge.setSolver(deployedContractAddress);

        Solver solver = Solver(deployedContractAddress);
        assertEq(
            solver.whatIsTheMeaningOfLife(),
            0x000000000000000000000000000000000000000000000000000000000000002a
        );

        uint256 size;
        assembly {
            size := extcodesize(solver)
        }
        assertLe(size, 10, "Require the solver to have at most 10 opcodes.");

        vm.stopPrank(  );
    }
}

