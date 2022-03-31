# Micropets-APP GitOps

This repository contains 2 mains folders:
* `applications` contains the resources provided by the Continuous Integration process that automatically commits the configuration of the 5 microservices (mainly the new image location) 
* `environment` contains the values of the differents Kubernetes clusters that are holding the *micropet* application (ingress provider, internal & external dns name, the service configuration)

The `Deliverables` refering `ClusterDeliveries` deployed on the target cluster pulls this information and turns them into Kubernetes resource ready to be deployed.

````
├── README.md
├── applications
│   ├── loader
│   │   └── 001
│   │       └── resources.yaml
│   └── micropets
│       ├── cats
│       │   ├── schema.yaml
│       │   └── values.yaml
│       ├── dogs
│       │   ├── schema.yaml
│       │   └── values.yaml
│       ├── fishes
│       │   ├── schema.yaml
│       │   └── values.yaml
│       ├── gui
│       │   ├── schema.yaml
│       │   └── values.yaml
│       └── pets
│           ├── schema.yaml
│           └── values.yaml
└── environments
    ├── aws
    │   ├── aws-front
    │   │   └── environment-values.yaml
    │   ├── tkg-europe-3
    │   │   └── environment-values.yaml
    │   └── tkg-uat-1
    │       └── environment-values.yaml
    ├── azure
    │   └── aks-east-2
    │       └── environment-values.yaml
    └── vsphere
````

## Deploy Deliverable:

```shell
MICROPETS_environment=vsphere/c1 make namespace k-deliverables
```

```shell
MICROPETS_environment=vsphere/c1 make namespace kapp-deliverables
```

```shell
MICROPETS_application=micropets/20220329 MICROPETS_environment=aws/aws-north make kapp-deliverables
```