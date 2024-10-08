import { defaultWagmiConfig } from '@web3modal/wagmi/react/config';
import { cookieStorage, createStorage, http } from 'wagmi';
import { foundry, sepolia } from 'wagmi/chains';

export const projectId = process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID;

if (!projectId) throw new Error('Project ID is not defined');

const metadata = {
    name: 'Fundr',
    description: process.env.NEXT_PUBLIC_WEBSITE_DESCRIPTION!,
    url: process.env.NEXT_PUBLIC_WEBSITE_URL!, // origin must match your domain & subdomain
    icons: ['https://avatars.githubusercontent.com/u/37784886'],
};

export const config = defaultWagmiConfig({
    chains: [process.env.NEXT_PUBLIC_NETWORK === 'sepolia' ? sepolia : foundry],
    projectId,
    metadata,
    ssr: true,
    storage: createStorage({
        storage: cookieStorage,
    }),
    transports: {
        [sepolia.id]: http(
            `https://eth-sepolia.g.alchemy.com/v2/${process.env.NEXT_PUBLIC_ALCHEMY_API_KEY}`
        ),
        [foundry.id]: http('http://localhost:8545'),
    },
});
