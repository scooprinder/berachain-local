# Local Berachain

## What is Local Berachain?

Local Berachain is a complete Berachain Devnet and ecosystem containerized with Docker and orchestrated with a simple `docker-compose` file. It simplifies the way smart-contract developers test their contracts in a sandbox before they deploy them on a testnet or mainnet.

Local Berachain comes preconfigured with opinionated, sensible defaults for standard testing environments. If other projects mention testing on Local Berachain, they are referring to the settings defined in this repo.

Local Berachain has the following advantages over a public testnet:

- Easily modifiable world states
- Quick to reset for rapid iterations
- Simple simulations of different scenarios
- Controllable validator behavior
- Off-chain Oracle service.

## Prerequisites

- [`Docker`](https://www.docker.com/)
- [`docker-compose`](https://github.com/docker/compose)
- [`berad`](https://berachain.com)
- Supported known architecture: x86_64
- 16+ GB of RAM is recommended

## Install Local Berachain

1. Run the following commands::

```sh
git clone https://github.com/berachain/berachain-local.git
cd berachain-local
```

2. Make sure your Docker daemon is running in the background and [`docker-compose`](https://github.com/docker/compose) is installed.

If running on linux, you can install these tools with the following commands:

- docker
```
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt install docker.io -y
```
- docker-compose
```
sudo apt install docker-compose -y
```

## Start, stop, and reset Local Berachain

- Start Local Berachain:

```sh
make start
```

Your environment now contains:
- Ethereum JSON-RPC http RPC node running on `http://localhost:8545`
- Ethereum JSON-RPC websocket RPC node running on `ws://localhost:8546`
- Tendermint RPC node running on `tcp://localhost:26657`
- LCD running on http://localhost:1317


Stop Local Berachain (and retain chain data):

```sh
make stop
```

Stop Local Berachain (and delete chain data):

```sh
make restart
```

Upgrade to latest Nightly:

```sh
make update
```

## Configure Local Berachain

The majority of Local Berachain is implemented through a `docker-compose.yml` file, making it easily customizable. You can use Local Berachain as a starting template point for setting up your own local Berachain devnet with Docker containers.

Out of the box, Local Berachain comes preconfigured with opinionated settings such as:

- ports defined for the Berachain Oracle Service (7171), Tendermint (26653, 26657), LCD (1317), EVM Http (8545), and EVM Websocket (8546)
- standard [accounts](#accounts)

### Modifying node configuration

You can modify the node configuration of your validator in the `config/config.toml` and `config/app.toml` files.

#### Pro tip: Speed Up Block Time

To decrease block time, edit the `[consensus]` parameters in the `config/config.toml` file, and specify your own values.

The following example configures all timeouts to `200ms`:

```diff
##### consensus configuration options #####
[consensus]

wal_file = "data/cs.wal/wal"
- timeout_propose = "3s"
- timeout_propose_delta = "500ms"
- timeout_prevote = "1s"
- timeout_prevote_delta = "500ms"
- timeout_precommit_delta = "500ms"
- timeout_commit = "5s"
+ timeout_propose = "200ms"
+ timeout_propose_delta = "200ms"
+ timeout_prevote = "200ms"
+ timeout_prevote_delta = "200ms"
+ timeout_precommit_delta = "200ms"
+ timeout_commit = "200ms"
```

Additionally, you can use the following single line to configure timeouts:

```sh
sed -E -i '/timeout_(propose|prevote|precommit|commit)/s/[0-9]+m?s/200ms/' config/config.toml
```

### Modifying genesis

You can change the `genesis.json` file by altering `config/genesis.json`. To load your changes, restart your Local Berachain.

## Accounts

Local Berachain is pre-configured with one validator and 10 accounts with BERA balances.

```yaml
accounts:
  - name: account0
    address: bera1h2hh3lqda8hv8ekyk34034zpes2vzws9lqevg0
    ethaddress: 0xBaaF78Fc0de9eEc3e6c4B46aF8d441Cc14c13A05
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"A2cYVNVpXQDe7TW+5VLh+z01ySlEZ48rHXctyYIeVmwi"}'
    mnenomic: distance lunch cereal install movie payment order body purse property hospital arrange ketchup purchase observe motion category helmet reform sample garlic usage install unfold
    coins: 1000000000000000000000000000abera
  - name: account1 
    address: bera1u8d0jafyytxnphsu4cj4e0trt7cseuxkmmnyxx
    ethaddress: 0xe1daf9752422Cd30DE1CAE255Cbd635fB10cf0D6
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"AtZLJyPEAA+60JxhTS81+HbFOHAzScrDw9KnEKeyjMbs"}'
    mnemonic: spring defense pencil girl success another peasant shiver silent buddy engage dice guard shield void engine laptop describe state beach tilt romance ready clog
    coins: 1000000000000000000000000000abera
  - name: account2
    address: bera10r5tezfg9vsdfkfxcm47j2rjshfg68phpkknu9
    ethaddress: 0x78E8bC89282b20D4D926C6EBE9287285d28d1c37
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"Anz+5p3IKybUg4gVSfYdw3h/Ub30q0otDb8GksCD5PeB"}'
    mnemonic: crystal bonus same mosquito cruise decade hurdle owner tooth clown trick fuel message order arm text lobster law artist more glory pencil measure soccer
    coins: 1000000000000000000000000000abera
  - name: account3
    address: bera19l5fp44k6k6n53z6556j564m7jfpt7nagnwmwh
    ethaddress: 0x2fe890d6b6d5b53A445Aa5352A6AbbF49215FA7d
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"Ao+5jVAIGqKJX5fpHNBDQGxd2f5MFXj0s64HYkNludgS"}'
    mnemonic: van wave misery chair dress cage brass enlist report knife planet demise accuse kitchen return silver make mobile noble bundle spy fade luxury talent
    coins: 1000000000000000000000000000abera
  - name: account4
    address: bera1x4gkunk96ycyzpxknn2dxspnh30mwt8ne0k7ka
    ethaddress: 0x35516E4eC5d1304104D69Cd4D34033bc5fb72Cf3
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"AjJWLyQS20jnC0Hy/n6A5J/9jW+Fa6M++pZ1BVYuqzAq"}'
    mnemonic: lawn wool light wonder liberty negative jungle beauty include nut whisper infant burger sustain buddy sauce monitor kitchen limb boost select auction orchard fiction
    coins: 1000000000000000000000000000abera
  - name: account5
    address: bera1jwtzd5667stwntcwaxnt83dr2rp0qmzxpfk23j
    ethaddress: 0x939626D35Af416e9af0EE9a6b3C5a350c2F06C46
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"A7kLl1bbCVmPCvavf582U3sWepw0c/PSRzGAQ4/RDjUP"}'
    mnemonic: imitate summer end fold trumpet ring tennis concert hip position breeze pond crisp spice ball base clock winner elephant kick win exchange rookie relief
    coins: 1000000000000000000000000000abera
  - name: account6
    address: bera1rvadu7d67wqjvv5hjtfmlmcqnl0c8wq9xturza
    ethaddress: 0x1B3ade79baf38126329792d3bFEf009FDF83b805
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"AkQuz7nbIm/id5NBBti6hmq9uSHcjtDGVpg0PqnRYX5h"}'
    mnemonic: gather shine enrich coral lab broccoli birth six gorilla captain life club say hedgehog dragon eagle tumble prosper image cotton beef spoon comic carpet
    coins: 1000000000000000000000000000abera
  - name: account7
    address: bera1jayk3m5mz9mtdphr0hdjgjw6zhtvfkgeuxuew8
    ethaddress: 0x974968Ee9B1176b686E37DDb2449dA15D6C4d919
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"AoYXaFgUIdOoweaunzs7JskV8iorh17Rt4zru0amrjvG"}'
    mnemonic: wide sound tail innocent cousin coast crane scatter jaguar smooth power hip enemy case only ivory chicken always corn elite truly result soup alcohol
    coins: 1000000000000000000000000000abera
  - name: account8
    address: bera1gychrvuw609f7cg5a34c2z3j7lhd2ya6kf78e6
    ethaddress: 0x413171b38Ed3CA9f6114EC6b850a32f7Eed513Ba
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"A14bUOwBjZeq/2+bWXQaYqMCqBYqAfWhgZKy/Y78hAQC"}'
    mnemonic: identify camera lecture filter final fatigue bring kit high arctic ability tattoo guard glory finish river recycle much pen hedgehog only wrong taste sadness
    coins: 1000000000000000000000000000abera
  - name: account9
    address: bera10awq6xscgpda7pqpk628yauws5etumn5we0f9q
    ethaddress: 0x7f5C0D1a18405BDF0401B69472778e8532BE6e74
    pubkey: '{"@type":"/ethermint.crypto.v1.ethsecp256k1.PubKey","key":"A3AC74U5e7mazw2krPP0oRG6f/UbVIN2pE3JbV07N5Hn"}'
    mnemonic: slender acid side nothing dirt road agree disorder erode atom negative shield theory oil denial rubber disorder palm toilet plug galaxy end prize antique
    coins: 1000000000000000000000000000abera
```

## Common issues

### Docker permissions problems

In case you get permission denied while trying to run `make start`

```
make start

Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: dial unix /var/run/docker.sock: connect: permission denied
```

**Check that the docker engine is running:**

```bash
sudo systemctl status docker
```

If not:

```bash
# Configure Docker to start on boot
sudo systemctl enable docker.service

# Start docker service
sudo systemctl start docker.service
```

**Ensure that the current user is in the `docker` group:**

1. Create the docker group and add your user

```bash
# Create the docker group
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER
```

2. Log out and log back in so that your group membership is re-evaluated.

More details can be found [here](https://docs.docker.com/engine/install/linux-postinstall/).