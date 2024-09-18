// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {DeployFundr} from "../../script/DeployFundr.s.sol";
import {Fundr} from "../../src/Fundr.sol";
import {FundingVault} from "../../src/FundingVault.sol";
import {VotingPowerToken} from "../../src/VotingPowerToken.sol";
import {Test} from "forge-std/Test.sol";

contract FundrTest is Test {
    HelperConfig helperConfig;
    Fundr fundr;

    event FundingVaultDeployed(address indexed fundingVault);

    function setUp() external {
        DeployFundr deployFundr = new DeployFundr();
        (fundr, helperConfig) = deployFundr.run();
    }

    function testDeployFundr() public view {
        assertTrue(address(fundr) != address(0), "Fundr should be deployed");
        assertTrue(address(helperConfig) != address(0), "HelperConfig should be deployed");
    }

    function testDeployFundingVaultZeroAddress() public {
        vm.expectRevert(Fundr.Fundr__CannotBeAZeroAddress.selector);
        fundr.deployFundingVault(address(0), address(1), 1, 10, block.timestamp + 1 days);
    }

    function testDeployFundingVaultTallyDateInPast() public {
        vm.warp(100 days);
        vm.expectRevert(Fundr.Fundr__TallyDateCannotBeInThePast.selector);
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp - 1 days);
    }

    function testDeployFundingVaultMinGreaterThanMax() public {
        vm.expectRevert(Fundr.Fundr__MinRequestableAmountCannotBeGreaterThanMaxRequestableAmount.selector);
        fundr.deployFundingVault(address(1), address(1), 10, 1, block.timestamp + 1 days);
    }

    function testDeployFundingVaultSuccess() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        assertEq(fundr.getTotalNumberOfFundingVaults(), 1);
    }

    function testVotingTokenNameAndSymbol() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        FundingVault fundingVault = FundingVault(fundr.getFundingVault(1));
        VotingPowerToken votingToken = VotingPowerToken(fundingVault.getVotingPowerToken());
        assertEq(votingToken.name(), "Voting Power Token 1");
        assertEq(votingToken.symbol(), "VOTE_1");
    }

    function testVotingPowerTokenOwnership() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        FundingVault fundingVault = FundingVault(fundr.getFundingVault(1));
        VotingPowerToken votingToken = VotingPowerToken(fundingVault.getVotingPowerToken());
        assertEq(votingToken.owner(), address(fundingVault));
    }

    function testFundingVaultOwnership() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        FundingVault fundingVault = FundingVault(fundr.getFundingVault(1));
        assertEq(fundingVault.getDeployer(), address(fundr));
    }

    function testSuccessfullDeploymentEmitEvent() public {
        vm.expectEmit(false, false, false, false);
        emit FundingVaultDeployed(address(0));
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
    }

    function testGetFundingVault() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        assertEq(fundr.getFundingVault(1), fundr.getFundingVault(1));
    }

    function testGetTotalNumberOfFundingVaults() public {
        fundr.deployFundingVault(address(1), address(1), 1, 10, block.timestamp + 1 days);
        assertEq(fundr.getTotalNumberOfFundingVaults(), 1);
    }
}
