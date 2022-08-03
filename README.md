# Local Berachain

## What is Local Berachain?

Local Berachain is a complete Berachain Devnet and ecosystem containerized with Docker and orchestrated with a simple `docker-compose` file. It simplifies the way smart-contract developers test their contracts in a sandbox before they deploy them on a testnet or mainnet.

Local Berachain comes preconfigured with opinionated, sensible defaults for standard testing environments. If other projects mention testing on Local Berachain, they are referring to the settings defined in this repo.

Local Berachain has the following advantages over a public testnet:

- Easily modifiable world states
- Quick to reset for rapid iterations
- Simple simulations of different scenarios
- Controllable validator behavior

## Prerequisites

- [`Docker`](https://www.docker.com/)
- [`docker-compose`](https://github.com/docker/compose)
- [`Berachaind`](https://get.Berachain.zone)
  * Select option 3 (Local Berachain), the installer will configure everything for you. 
  * The Berachaind dameon on your local computer is used to communicate with the Local Berachain daemin running inside the Docker container. 
- Supported known architecture: x86_64
- 16+ GB of RAM is recommended

## Install Local Berachain

1. Run the following commands::

```sh
git clone https://github.com/berachain/local-berachain.git
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

## Configure Local Berachain

The majority of Local Berachain is implemented through a `docker-compose.yml` file, making it easily customizable. You can use Local Berachain as a starting template point for setting up your own local Berachain devnet with Docker containers.

Out of the box, Local Berachain comes preconfigured with opinionated settings such as:

- ports defined for Tendermint RPC (26657), LCD (1317), EVM http (8545), and EVM websocket (8546)
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

Local Berachain is pre-configured with one validator and 10 accounts with ION and OSMO balances.

| Account   | Address                                                                                                  | Mnemonic                                                                                                                                                                   |
| --------- | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| validator | `osmo1phaxpevm5wecex2jyaqty2a4v02qj7qmlmzk5a`<br/>`osmovaloper1phaxpevm5wecex2jyaqty2a4v02qj7qm9v24r6` | `satisfy adjust timber high purchase tuition stool faith fine install that you unaware feed domain license impose boss human eager hat rent enjoy dawn`                    |
| test1     | `osmo1cyyzpxplxdzkeea7kwsydadg87357qnahakaks`                                                           | `notice oak worry limit wrap speak medal online prefer cluster roof addict wrist behave treat actual wasp year salad speed social layer crew genius`                       |
| test2     | `osmo18s5lynnmx37hq4wlrw9gdn68sg2uxp5rgk26vv`                                                           | `quality vacuum heart guard buzz spike sight swarm shove special gym robust assume sudden deposit grid alcohol choice devote leader tilt noodle tide penalty`              |
| test3     | `osmo1qwexv7c6sm95lwhzn9027vyu2ccneaqad4w8ka`                                                           | `symbol force gallery make bulk round subway violin worry mixture penalty kingdom boring survey tool fringe patrol sausage hard admit remember broken alien absorb`        |
| test4     | `osmo14hcxlnwlqtq75ttaxf674vk6mafspg8xwgnn53`                                                           | `bounce success option birth apple portion aunt rural episode solution hockey pencil lend session cause hedgehog slender journey system canvas decorate razor catch empty` |
| test5     | `osmo12rr534cer5c0vj53eq4y32lcwguyy7nndt0u2t`                                                           | `second render cat sing soup reward cluster island bench diet lumber grocery repeat balcony perfect diesel stumble piano distance caught occur example ozone loyal`        |
| test6     | `osmo1nt33cjd5auzh36syym6azgc8tve0jlvklnq7jq`                                                           | `spatial forest elevator battle also spoon fun skirt flight initial nasty transfer glory palm drama gossip remove fan joke shove label dune debate quick`                  |
| test7     | `osmo10qfrpash5g2vk3hppvu45x0g860czur8ff5yx0`                                                           | `noble width taxi input there patrol clown public spell aunt wish punch moment will misery eight excess arena pen turtle minimum grain vague inmate`                       |
| test8     | `osmo1f4tvsdukfwh6s9swrc24gkuz23tp8pd3e9r5fa`                                                           | `cream sport mango believe inhale text fish rely elegant below earth april wall rug ritual blossom cherry detail length blind digital proof identify ride`                 |
| test9     | `osmo1myv43sqgnj5sm4zl98ftl45af9cfzk7nhjxjqh`                                                           | `index light average senior silent limit usual local involve delay update rack cause inmate wall render magnet common feature laundry exact casual resource hundred`       |
| test10    | `osmo14gs9zqh8m49yy9kscjqu9h72exyf295afg6kgk`                                                           | `prefer forget visit mistake mixture feel eyebrow autumn shop pair address airport diesel street pass vague innocent poem method awful require hurry unhappy shoulder`     |

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