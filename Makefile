run-tmp:
	cargo run -- --dev --tmp

run:
	cargo run -- --dev

toolchain:
	./scripts/init.sh

build:
	cargo build

build-release:
	cargo build --release

check:
	SKIP_WASM_BUILD= cargo check --all --tests

test:
	SKIP_WASM_BUILD= cargo test --all

purge:
	cargo run -- purge-chain --dev -y

purge-alice:
	./target/release/node-template purge-chain --base-path /tmp/alice --chain local

alice:
	./target/release/node-template \
	--base-path /tmp/alice \
	--chain local \
	--alice \
	--port 30333 \
	--ws-port 9945 \
	--rpc-port 9933 \
	--node-key 0000000000000000000000000000000000000000000000000000000000000001 \
	--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
  --name validator-alice-sha888 \
  --validator

purge-bob:
	./target/release/node-template purge-chain --base-path /tmp/bob --chain local

bob:
	./target/release/node-template \
	--base-path /tmp/bob \
	--chain local \
	--bob \
	--port 30334 \
	--ws-port 9946 \
	--rpc-port 9934 \
	--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
  --name validator-alice-sha888 \
  --validator \
	--bootnodes /ip4/127.0.0.1/tcp/30333/p2p/12D3KooWQ6Qje2qmK9ChLMUAPUXfj16CjMxJLdfGwMhfssjJmVjN

custom-spec:
	./target/release/node-template build-spec --disable-default-bootnode --chain local > customSpec.json

raw-custom-spec:
	./target/release/node-template build-spec --chain=customSpec.json --raw --disable-default-bootnode > customSpecRaw.json

purge-node01:
	./target/release/node-template purge-chain --base-path /tmp/node01 --chain local -y

node01:
	./target/release/node-template \
	--base-path /tmp/node01 \
	--chain ./customSpecRaw.json \
	--port 30333 \
	--ws-port 9945 \
	--rpc-port 9933 \
	--telemetry-url 'wss://telemetry.polkadot.io/submit/ 0' \
	--validator \
	--rpc-methods Unsafe \
	--name MyNode01

