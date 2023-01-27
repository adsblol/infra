# adsblol/infra

This is the adsb.lol infrastructure.
It aims to aggregate [ADS-B](https://github.com/wiedehopf/readsb) & [MLAT](https://github.com/wiedehopf/mlat-server)

The repo should contain everything for you to be able to run a copy of this service.

## Why?

Due to recent events regarding ADSBExchange being acquired, it would be wise for the community to have a quick and easy way to deploy an alternative aggregation service.

## How?

Right now, the infrastructure's entrypoint is meant to be `manifests/default`

You can see what manifests would end up on the cluster by doing `kustomize build manifests/default`.

Should you need to copy this for your own infrastructure, an understanding of Kubernetes and Kustomize is recommended.

## What?

### bases
The `bases` folder contains basic Kubernetes components. These will be reused later.

#### mlat-server
Running wiedehopf's mlat-server

#### readsb
Running wiedehopf's readsb

### manifests
The `manifests` folder is closer to the expected state of the cluster.

Everything is inherited from a component in `bases` and then patched as necessary.

#### ingest (readsb)
This is meant to be the publicly accessible ingest readsb. Can be scaled if needed.

[This reasdb sends data to the hub readsb](manifests/ingest/default/kustomization.yaml#L10-15)

##### base
This is a pattern you will see throughout this repo.

The general idea is that `base` inherits, or defines a basic deployment of the application.

##### default
The general idea is that `default` has the patches for this service to be configured properly.
**This would include any environment variables, etc.**

#### mlat (mlat-server)
Runs mlat-server

#### hub (readsb)
A copy of readsb aggregating ingest data

[This readsb sends data to the planes readsb](manifests/hub/default/kustomization.yaml#L8-13)

#### planes (readsb)
A copy of readsb, with its tar1090 instance exposed to the public.

#### resources.yaml
Global (to the namespace) resources such as publicly-intended services and ingresses, NetworkPolicies.


## Where?

user -> ingest -> hub -> planes

ingest -> mlat -> hub -> planes
