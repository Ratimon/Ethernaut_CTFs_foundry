// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

import {Script} from "@forge-std/Script.sol";
import {PuzzleProxy, PuzzleWallet} from "@main/24_PuzzleWallet.sol";

contract DeployPuzzleWalletScript is Script {

    // PuzzleWallet walletLogic;
    // PuzzleProxy proxy;
    PuzzleWallet walletChallenge;

    function run() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // string memory mnemonic = vm.envString("MNEMONIC");

        // address is already funded with ETH
        string memory mnemonic ="test test test test test test test test test test test junk";
        uint256 deployerPrivateKey = vm.deriveKey(mnemonic, "m/44'/60'/0'/0/", 1); //  address = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // deploy the PuzzleWallet logic
        PuzzleWallet walletLogic = new PuzzleWallet();

        // deploy proxy and initialize implementation contract
        bytes memory data = abi.encodeWithSelector(PuzzleWallet.init.selector, 100 ether);
        PuzzleProxy proxy = new PuzzleProxy(deployer, address(walletLogic), data);

        walletChallenge = PuzzleWallet(address(proxy));

        // whitelist this contract to allow it to deposit ETH
        walletChallenge.addToWhitelist(deployer);
        walletChallenge.deposit{value: 0.001 ether}();

        vm.stopBroadcast();
    }
}