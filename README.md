# Script
 
**A Peer-to-Peer Transaction Protocol for the Internet, Intranets, and Mesh Networks**
 
*by Supernova Labs Ltd*
 
---
 
## What is Script?
 
Script is the substrate on which the next evolution of civilisation transacts, interconnects, and learns.
 
Seventeen years of cryptocurrency development produced extraordinary infrastructure — and an extraordinary amount of wasted compute. Miners worldwide burn energy grinding nonces to satisfy an arbitrary difficulty target. Script inherits the proven mechanics of that era and replaces the waste with purpose.
 
Money was always only the base layer. Smart contracts, verifiable data provenance, and machine-readable agreements between human and non-human parties — that is where the technology was always headed. Script is where it arrives.
 
---
 
## Proof of Useful Work
 
Standard Proof of Work asks miners to find a number that makes a hash look a certain way. It is deliberately pointless. The difficulty exists to make cheating expensive, but the compute itself produces nothing.
 
Script replaces this with **Proof of Useful Work (PoUW)** — where the work miners perform is the work the network actually needs done.
 
In Script's implementation, PoUW takes a specific form we call **Proof of Learning**.
 
---
 
## Proof of Learning
 
Script is designed to store typed, structured data on-chain — not arbitrary bytes. Every block is a timestamped, consensus-ordered record of real-world transactions, contracts, and state transitions.
 
Proof of Learning puts that data to work.
 
Each mining cycle, instead of grinding nonces:
 
1. **New block data arrives.** The network agrees on the next batch of transactions.
2. **Workers embed the data.** The block content is passed through an embedding model, producing a vector representation.
3. **Diffs are computed.** The vector delta between the new block and the chain tip is calculated — a precise measure of what changed semantically, not just syntactically.
4. **A continual learning step runs.** The network's shared model takes a gradient step on the delta, updating its understanding of the domain the chain represents.
5. **The proof is produced.** A verifiable commitment to the weight delta and updated checkpoint hash is submitted alongside the block.
6. **The block is valid if the proof verifies.** Validators run a deterministic inference check against the submitted checkpoint — cheap to verify, expensive to fake.
The result is a chain that does not merely record history. It learns from it.
 
---
 
## Worker-Miners
 
There is no reason mining and learning should be separate roles. On a single GPU they are sequential pipeline stages:
 
- **Worker phase** — embed the block data, compute the diff, run the gradient step, produce the weight delta.
- **Miner phase** — hash the weight delta alongside the previous block header, find a valid nonce.
The worker phase produces exactly what the miner phase needs. A node running both captures the full block reward. Nodes that opt out of the worker phase can still mine against others' submitted deltas, but earn proportionally less. The network naturally gravitates toward useful compute over wasted compute.
 
---
 
## The Chain as Training Curriculum
 
A blockchain is a totally ordered, tamper-evident log. For continual learning, that is a significant property.
 
- **You always know what is new.** The delta between the current tip and any prior checkpoint is exact and unambiguous — no dataset reconciliation required.
- **Training runs are reproducible.** Any model state can be anchored to a block hash. Replay the chain, recover the checkpoint.
- **Forks map to model branching.** A chain fork is two divergent fine-tuning runs from a common ancestor. The canonical chain is the canonical model.
- **Domain drift is measurable.** If the chain stores semantically typed data — cooperative actions, sensor telemetry, contract executions — the vector diffs carry meaning. You are not tracking data volume. You are tracking how the domain itself evolves.
---
 
## What is Script?
 
Script is a peer-to-peer transaction protocol for the internet, intranets, and mesh networks at global scale.
 
Peer-to-peer means no central authority. Transactions and data are managed collectively by the network — that means you, your friends, the organisations you trust, and the machines you run. You can operate as a full node (download the entire ledger, help secure the network, act as a source of truth), or use a wallet as a currency, or integrate Script as a decentralised API layer in projects where transparency and accountability matter.
 
Script has an extensible smart contracting framework built in. The world runs on contracts and the authorities that mediate them. Traditional contracting requires specialised drafting, complex negotiation, and expensive dispute resolution. Script replaces that with self-executing contracts — programmes that run automatically when conditions are met, signed with digital signatures, with no intermediary required.
 
All transactions are posted to a public ledger. Wallet addresses are pseudonymous by default, but not anonymous once linked to identifying information. Our model is straightforward: **transparency and accountability for trusted authorities and governance; privacy for everyone else.** Encrypted transactions are on the roadmap.
 
---
 
## What Script Is Built On
 
Script's underlying code is a blend of Bitcoin and Dogecoin — and greater than the sum of their parts. It inherits Bitcoin's tried and tested UTXO mechanics and Dogecoin's lightweight agility, extended with the PoUW/PoL consensus layer and a smart contracting framework designed for non-human as well as human signatories.
 
This is not a clean-room reimagining. It is seventeen years of accumulated knowledge, kept and extended where it earned its keep, discarded where it did not.
 
---
 
## License
 
Script is released under the terms of the **Hippocratic License**. See `LICENSE` for more information or visit [https://firstdonoharm.dev](https://firstdonoharm.dev).
 
This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit, cryptographic software written by Eric Young, and UPnP software written by Thomas Bernard.
 
---
 
## Development
 
This repository contains the source code of releases. Contributions via Pull Request are welcome.
 
We are looking for:
- UTXO coin developers with Bitcoin or Dogecoin codebase experience
- Developers with experience in sCrypt (Bitcoin smart contracting language)
- ML engineers interested in on-chain continual learning and ZK-ML proof systems
- Anyone who wants to build the substrate the next civilisation runs on
Contact: [adam@supernovalabs.co.uk](mailto:adam@supernovalabs.co.uk)
 
See `doc/README.md` for installation, build, and development instructions. You will need some technical comfort with a Linux terminal. That is the only barrier. We believe in you.
 
---
 
## Disclosure
 
We have a responsible disclosure policy for security issues. See `SECURITY.md`.
 
---
 
*We owe a debt of gratitude to Satoshi, to the builders who sought to free the world, to the cypherpunks, and to everyone who got us all to where we are today. The next step is yours to take.*
 

