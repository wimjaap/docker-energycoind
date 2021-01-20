**Prerequisites**

Requires that Docker be installed on the host machine. This requires at least Docker 17.05 for both daemon and client due to the multi-stage build.

**Building**

If you like to build it from these sources, for a new Energycoin daemon version for example, follow these instructions.
$ docker build --no-cache -t wimjaap/energycoind:latest .

**Running**

If you just want to run a node, follow these!
Create a directory to store Energycoin data

```$ mkdir ~/energycoin_data```

Pull the latest version and run with your parameters. See below for all parameters.

```$ docker pull wimjaap/energycoind:latest```

```$ docker run --name energycoind -d --env 'ENRG_RPCUSER=user' --env 'ENRG_RPCPASSWORD=password' --volume ~/energycoin_data:/energycoin --publish 22705:22706 wimjaap/energycoind```

**Configuration**

A custom energycoin.conf file can be placed in the mounted data directory. Otherwise, a default energycoin.conf file will be automatically generated based on environment variables passed to the container:

|name|default|
|---|---|
|ENRG_RPCUSER|user|
|ENRG_RPCPASSWORD|password|
|ENRG_RPCALLOWIP|127.0.0.1|
|ENRG_DISABLEWALLET|0|
|ENRG_STAKING|1|
|ENRG_TXINDEX|1|

Of course you are free to change, or add any parameter the energycoin.conf after running.

**Sending commands to the energycoind container**
You can use another container to sends commands to your energycoind container. This way you can manage your wallet, unlock your wallet for staking etc.
For a full list run:

```$ docker run --rm --network container:energycoind --volume ~/energycoin_data:/energycoin wimjaap/energycoind help```

**Staking**

Make sure staking=1 and disablewallet=0 is set in your configuration, these are the default values.
Send some coins from an exchange to your ENRG address, you can find it by running:

```$ docker run --rm --network container:energycoind --volume ~/energycoin_data:/energycoin wimjaap/energycoind getaccountaddress ""```

**Encrypt your wallet using a passphrase**

```$ docker run --rm --network container:energycoind --volume ~/energycoin_data:/energycoin wimjaap/energycoind encryptwallet 'my secret passphrase'```

Your energycoind will stop. Restart it with:

```$ docker start energycoind```

Now you can unlock your wallet using "walletpassphrase". This command needs a "minutes" argument. The wallet will be unlocked for this amount of minutes. Also, optional you can add a "mintonly" argument to unlock for staking only.

```$ docker run --rm --network container:energycoind --volume ~/energycoin_data:/energycoin wimjaap/energycoind walletpassphrase 'my secret passphrase' 3600 true```

Example command would unlock the wallet for an hour with my passphrase and unlock for staking only. If you want to unlock "forever", set the minutes to the maximum: 9999999999999999999. As an alternative you could also use cron or "Scheduled Tasks" to run the unlock at an interval. Note, if you wish to extend the unlock time, send a "walletlock" command first.

**Donate / Credits**

If you like this and have some spare coins, you're always welcome to donate! =) Bugs and suggestions, contact me!

BTC: bc1qqyja5fyxx93sywcvzrx23s76n4r46za5y9ux3khuyylttkqtk64qmfe7wm
