// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Fundr} from "../src/Fundr.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundr is Script {
    function run() external returns (Fundr fundr, HelperConfig helperConfig) {
        helperConfig = new HelperConfig();
        uint256 deployerKey = helperConfig.activeNetworkConfig();

        vm.startBroadcast(deployerKey);
        uint256 platformFee = 5;
        fundr = new Fundr(platformFee);
        vm.stopBroadcast();
        string memory deploymentInfo = string.concat('{"Fundr":"', vm.toString(address(fundr)), '"}');
        vm.writeFile("../web-app/src/blockchain/deployments/sepolia/fundr_deployment.json", deploymentInfo);
    }
}
