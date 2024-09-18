import fundrDeploymentDev from '@/blockchain/deployments/anvil/fundr_deployment.json';
import fundrDeploymentProd from '@/blockchain/deployments/sepolia/fundr_deployment.json';
// import mockFundrABI from '@/blockchain/out/MockFundr.sol/MockFundr.json';
import fundrABI from '@/blockchain/out/Fundr.sol/Fundr.json';

// import erc20DeploymentDev from '@/blockchain/deployments/anvil/erc20_deployment.json';
import erc20 from '@/blockchain/out/ERC20.sol/ERC20.json';

// import mockFundingVault from '@/blockchain/out/MockFundingVault.sol/MockFundingVault.json';
import fundingVault from '@/blockchain/out/FundingVault.sol/FundingVault.json';

let mockFundrABI, mockFundingVault, erc20DeploymentDev;
if (process.env.NODE_ENV === 'development') {
    mockFundrABI = require('@/blockchain/out/MockFundr.sol/MockFundr.json');
    mockFundingVault = require('@/blockchain/out/MockFundingVault.sol/MockFundingVault.json');
    erc20DeploymentDev = require('@/blockchain/deployments/anvil/erc20_deployment.json');
}

export const Fundr: SmartContract = {
    address:
        process.env.NODE_ENV === 'development'
            ? fundrDeploymentDev.mockFundr
            : fundrDeploymentProd.Fundr,
    abi:
        process.env.NODE_ENV === 'development'
            ? mockFundrABI.abi
            : fundrABI.abi,
};

export const erc20ABI = erc20.abi;

export const fundingVaultABI =
    process.env.NODE_ENV === 'development'
        ? mockFundingVault.abi
        : fundingVault.abi;
