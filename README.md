<div align="center">

  <img src="docs/img/floo_noc_logo.png" alt="Logo" width="300">

# FlooNoC: A Fast, Low-Overhead On-chip Network
</div>

<a href="https://pulp-platform.org">
<img src="docs/img/pulp_logo_icon.svg" alt="Logo" width="100" align="right">
</a>

This repository provides modules for the FlooNoC, a Network-on-Chip (NoC) which is part of the [PULP (Parallel Ultra-Low Power) Platform](https://pulp-platform.org/). The repository includes Network Interface IPs (named chimneys), Routers and further NoC components to build a complete NoC. FlooNoC mainly supports [AXI4+ATOPs](https://github.com/pulp-platform/axi/tree/master), but can be easily extended to other On-Chip protocols. Arbitrary topologies are supported with several routing algorithms. FlooNoC is designed to be scalable and modular, and can be easily extended with new components. <br><br>

<div align="center">

[![CI status](https://github.com/pulp-platform/FlooNoC/actions/workflows/gitlab-ci.yml/badge.svg?branch=main)](https://github.com/pulp-platform/FlooNoC/actions/workflows/gitlab-ci.yml?query=branch%3Amain)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/pulp-platform/FlooNoC?color=blue&label=current&sort=semver)](CHANGELOG.md)
![License](https://img.shields.io/badge/license-SHL--0.51-green)

[Design Principles](#-design-principles) •
[Getting started](#-getting-started) •
[List of IPs](#-list-of-ips) •
[Configuration](#-configuration) •
[License](#-license)

</div>

## 💡 Design Principles

Our NoC design is grounded in the following key principles:

1. **Full AXI4 Support**: Our design fully supports AXI4+ATOPs from AXI5 as outlined [here](https://github.com/pulp-platform/axi/tree/master), particularly multiple outstanding burst transactions. It utilizes low-complexity routers and a decoupled link-level protocol to ensure scalability, thereby enabling tolerance to high-latency off-chip accesses.
1. **Decoupled Links and Networks**: We use a link-level protocol that is decoupled from the network-level protocol. This allows us to move the complexity of the network-level protocol into the network interfaces, while deploying low-complexity routers in the network, that enable better scalability.
1. **Wide Physical Channels**: We incorporate wide physical channels in order to meet the high-bandwidth requirements at network endpoints without being constrained by the operating frequency. This is in contrast to the traditional narrow link approach. Further, the NoC avoids any kind of serialization and sends entire messages in a single flit including header and tail information.
1. **Separation of traffic**: Our design acknowledges the diversity in traffic patterns, as it decouples links and networks to handle wide, high-bandwidth, burst-based traffic and narrow, latency-sensitive traffic with separate physical channels.
1. **Modularity:** Our design principles also emphasize modularity. We have developed a set of IPs that can be instantiated together to build a NoC. This approach not only promotes reusability but also facilitates flexibility in designing custom NoCs to cater to a variety of specific system requirements.

## 🔮 Origin of the name

The names of the IPs are inspired by the [Harry Potter](https://en.wikipedia.org/wiki/Harry_Potter) universe, where the [Floo Network](https://harrypotter.fandom.com/wiki/Floo_Network) is a magical transportation system. The Network interfaces are named after the fireplaces and chimneys used to access the Floo Network.

> In use for centuries, the Floo Network, while somewhat uncomfortable, has many advantages. Firstly, unlike broomsticks, the Network can be used without fear of breaking the International Statute of Secrecy. Secondly, unlike Apparition, there is little to no danger of serious injury. Thirdly, it can be used to transport children, the elderly and the infirm."

## 🔐 License
Unless specified otherwise in the respective file headers, all code checked into this repository is made available under a permissive license. All hardware sources and tool scripts are licensed under the Solderpad Hardware License 0.51 (see [`LICENSE`](LICENSE))

## 📚 Publication
If you use FlooNoC in your research, please cite the following paper:
<details>
<summary><b>FlooNoC: A Multi-Tbps Wide NoC for Heterogeneous AXI4 Traffic</b></summary>
<p>

```
@misc{fischer2023floonoc,
      title={FlooNoC: A Multi-Tbps Wide NoC for Heterogeneous AXI4 Traffic},
      author={Tim Fischer and Michael Rogenmoser and Matheus Cavalcante and Frank K. Gürkaynak and Luca Benini},
      year={2023},
      eprint={2305.08562},
      archivePrefix={arXiv},
      primaryClass={cs.AR}
}
```

</p>
</details>

## ⭐ Getting Started

### Pre-requisites

FlooNoC uses [bender](https://github.com/pulp-platform/bender) to manage its dependencies and to automatically generate compilation scripts. Further `Python >= 3.8` is required with the packages listed in `requirements.txt`.

### Simulation
Currently, we do not provide any open-source simulation setup. Internally, the FlooNoC was tested using QuestaSim, which can be launched with the following command:

```sh
# Compile the sources
make compile-sim
# Run the simulation
make run-sim-batch VSIM_TB_DUT=tb_floo_dut
```

or in the GUI, with prepared waveforms:

```sh
# Compile the sources
make compile-sim
# Run the simulation
make run-sim VSIM_TB_DUT=tb_floo_dut
```
By replacing `tb_floo_dut` with the name of the testbench you want to simulate.

## 🧰 List of IPs

This repository includes the following NoC IPs:

1. **Routers:** A collection of different NoC router designs with varying features such as virtual channels, input/output buffering, and adaptive routing algorithms.
1. **Network Interfaces (NIs)**: A set of NoC network interfaces for connecting IPs to the NoC.
1. **Topologies:** A collection of NoC topologies, such as mesh, to enable the creation of various on-chip interconnects.
1. **Common IPs** A set of IPs used by the NoC IPs, such as FIFOs, Cuts and arbiters.
1. **Verification IPs (VIPs):** A set of VIPs to verify the correct functionality of the NoC IPs.
1. **Testbenches:** A set of testbenches to evaluate the performance of the NoC IPs, including throughput, latency.

### Routers
| Name | Description | Doc |
| --- | --- | --- |
| [floo_router](src/floo_router.sv) | A simple router with configurable number of ports, physical and virtual channels, and input/output buffers |  |
| [floo_narrow_wide_router](src/floo_narrow_wide_router.sv) | Wrapper of a multi-link router for narrow and wide links |  |

### Network Interfaces
| Name | Description | Doc |
| --- | --- | --- |
| [floo_axi_chimney](src/floo_axi_chimney.sv) | A bidirectional network interface for connecting AXI4 Buses to the NoC |  |
| [floo_narrow_wide_chimney](src/floo_narrow_wide_chimney.sv) | A bidirectional network interface for connecting narrow & wide AXI Buses to the multi-link NoC |  |

### Topologies
| Name | Description | Doc |
| --- | --- | --- |
| [floo_mesh](src/floo_mesh.sv) | A mesh topology with configurable number of rows and columns |  |
| [floo_mesh_ruche](src/floo_mesh_ruche.sv) | A mesh topology with ruche channels and a configurable number of rows and columns |  |

### Common IPs
| Name | Description | Doc |
| --- | --- | --- |
| [floo_fifo](src/floo_fifo.sv) | A FIFO buffer with configurable depth |  |
| [floo_cut](src/floo_cut.sv) | Elastic buffers for cuting timing paths |  |
| [floo_cdc](src/floo_cdc.sv) | A Clock-Domain-Crossing (CDC) module implemented with a gray-counter based FIFO. |  |
| [floo_wormhole_arbiter](src/floo_wormhole_arbiter.sv) | A wormhole arbiter |  |
| [floo_vc_arbiter](src/floo_vc_arbiter.sv) | A virtual channel arbiter |  |
| [floo_rob](src/floo_rob.sv) | A table-based Reorder Buffer |  |
| [floo_simple_rob](src/floo_simple_rob.sv) | A simplistic low-complexity Reorder Buffer |  |
| [floo_rob_wrapper](src/floo_simple_rob.sv) | A wrapper of all available types of RoBs including RoB-less version |  |

### Verification IPs
| Name | Description | Doc |
| --- | --- | --- |
| [axi_bw_monitor](test/axi_bw_monitor.sv) | A AXI4 Bus Monitor for measuring the throughput and latency of the AXI4 Bus |  |
| [axi_reorder_compare](test/axi_reorder_compare.sv) | A AXI4 Bus Monitor for verifying the order of AXI transactions with the same ID |  |
| [floo_axi_rand_slave](test/floo_axi_rand_slave.sv) | A AXI4 Bus Multi-Slave generating random AXI respones with configurable response time |  |
| [floo_axi_test_node](test/floo_axi_test_node.sv) | A AXI4 Bus Master-Slave Node for generating random AXI transactions |  |
| [floo_dma_test_node](test/floo_dma_test_node.sv) | An endpoint node with a DMA master port and a Simulation Memory Slave port |  |
| [floo_hbm_model](test/floo_hbm_model.sv) | A very simple model of the HBM memory controller with configurable delay |  |

## 🎛️ Configuration

The data structs for the flits and the links are auto-generated and can be configured in `util/*cfg.hjson`. The size of the links is automatically determined to fit the largest message going over the link into a single flit, in order to avoid any serialization.

The AXI channels(s) needs to be configured in `util/*cfg.hjson`. The following example shows the configuration for a single AXI channel with 64-bit data width, 32-bit address width, 3-bit ID width, and 1-bit user width (beware that ID width can be different for input and output channels).

```
  axi_channels: [
    {name: 'axi', direction: 'input', params: {dw: 64, aw: 32, iw: 3, uw: 1 }}
  ]
```
Multiple physical links can be declared and the mapping of the AXI channels to the physical link can be configured in `util/*cfg.json`. The following example shows the configuration for two physical channels, one for requests and one for responses. The mapping of the AXI channels to the physical link is done by specifying the AXI channels in the `map` field.

```
  channel_mapping: {
    req: {axi: ['aw', 'w', 'ar']}
    rsp: {axi: ['b', 'r']}
  }
```

FlooNoC does not send any header and tail flits to avoid serilization overhead. Instead additional needed routing information is sent in parallel and needs to be specified in the `routing` field. Examples for the different routing algorithms can be found in `util/*cfg.hjson`. The following example shows the configuration for a XY routing algorithm with 3-bit X and Y coordinates, 36-bit address offset, and 8-bit RoB index.

```
  routing: {
    route_algo: XYRouting
    num_x_bits: 3
    num_y_bits: 3
    addr_offset_bits: 36
    rob_idx_bits: 8
  }
```
Finally, the package source files can be generated with:

```sh
make sources
```
