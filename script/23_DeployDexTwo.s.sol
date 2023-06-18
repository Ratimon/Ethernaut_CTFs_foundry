// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {DexTwo, SwappableTokenTwo} from "@main/23_DexTwo.sol";

contract DeployDexTwoScript is Script {
    DexTwo dextwoChallenge;
    SwappableTokenTwo tokenOne;
    SwappableTokenTwo tokenTwo;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic = "test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8

        vm.startBroadcast(deployerPrivateKey);

        dextwoChallenge = new DexTwo();

        tokenOne = new SwappableTokenTwo(address(dextwoChallenge), "Token 1", "TKN1", 110);
        tokenTwo = new SwappableTokenTwo(address(dextwoChallenge), "Token 2", "TKN2", 110);

        // dextwoChallenge.setTokens(address(tokenOne), address(tokenTwo));
        // tokenOne.approve(address(dextwoChallenge), 100);
        // tokenTwo.approve(address(dextwoChallenge), 100);

        // dextwoChallenge.add_liquidity(address(tokenOne), 100);
        // dextwoChallenge.add_liquidity(address(tokenTwo), 100);

        // tokenOne.transfer(_player, 10);
        // tokenTwo.transfer(_player, 10);

        vm.stopBroadcast();
    }
}
