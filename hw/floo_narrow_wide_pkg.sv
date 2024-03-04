// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
//
// This file is auto-generated. Do not edit! Edit the template file instead

`include "axi/typedef.svh"

package floo_narrow_wide_pkg;

  import floo_pkg::*;

  ////////////////////////
  //   AXI Parameters   //
  ////////////////////////

  typedef enum logic [3:0] {
    NarrowAw = 0,
    NarrowW = 1,
    NarrowAr = 2,
    WideAr = 3,
    NarrowB = 4,
    NarrowR = 5,
    WideB = 6,
    WideAw = 7,
    WideW = 8,
    WideR = 9,
    NumAxiChannels = 10
  } axi_ch_e;


  localparam int unsigned AxiNarrowInAddrWidth = 48;
  localparam int unsigned AxiNarrowInDataWidth = 64;
  localparam int unsigned AxiNarrowInIdWidth = 4;
  localparam int unsigned AxiNarrowInUserWidth = 4;


  localparam int unsigned AxiNarrowOutAddrWidth = 48;
  localparam int unsigned AxiNarrowOutDataWidth = 64;
  localparam int unsigned AxiNarrowOutIdWidth = 2;
  localparam int unsigned AxiNarrowOutUserWidth = 4;


  localparam int unsigned AxiWideInAddrWidth = 48;
  localparam int unsigned AxiWideInDataWidth = 512;
  localparam int unsigned AxiWideInIdWidth = 3;
  localparam int unsigned AxiWideInUserWidth = 4;


  localparam int unsigned AxiWideOutAddrWidth = 48;
  localparam int unsigned AxiWideOutDataWidth = 512;
  localparam int unsigned AxiWideOutIdWidth = 1;
  localparam int unsigned AxiWideOutUserWidth = 4;


  typedef logic [47:0] axi_narrow_in_addr_t;
  typedef logic [63:0] axi_narrow_in_data_t;
  typedef logic [7:0] axi_narrow_in_strb_t;
  typedef logic [3:0] axi_narrow_in_id_t;
  typedef logic [3:0] axi_narrow_in_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_narrow_in, axi_narrow_in_req_t, axi_narrow_in_rsp_t, axi_narrow_in_addr_t,
                      axi_narrow_in_id_t, axi_narrow_in_data_t, axi_narrow_in_strb_t,
                      axi_narrow_in_user_t)


  typedef logic [47:0] axi_narrow_out_addr_t;
  typedef logic [63:0] axi_narrow_out_data_t;
  typedef logic [7:0] axi_narrow_out_strb_t;
  typedef logic [1:0] axi_narrow_out_id_t;
  typedef logic [3:0] axi_narrow_out_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_narrow_out, axi_narrow_out_req_t, axi_narrow_out_rsp_t,
                      axi_narrow_out_addr_t, axi_narrow_out_id_t, axi_narrow_out_data_t,
                      axi_narrow_out_strb_t, axi_narrow_out_user_t)


  typedef logic [47:0] axi_wide_in_addr_t;
  typedef logic [511:0] axi_wide_in_data_t;
  typedef logic [63:0] axi_wide_in_strb_t;
  typedef logic [2:0] axi_wide_in_id_t;
  typedef logic [3:0] axi_wide_in_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_wide_in, axi_wide_in_req_t, axi_wide_in_rsp_t, axi_wide_in_addr_t,
                      axi_wide_in_id_t, axi_wide_in_data_t, axi_wide_in_strb_t, axi_wide_in_user_t)


  typedef logic [47:0] axi_wide_out_addr_t;
  typedef logic [511:0] axi_wide_out_data_t;
  typedef logic [63:0] axi_wide_out_strb_t;
  typedef logic [0:0] axi_wide_out_id_t;
  typedef logic [3:0] axi_wide_out_user_t;
  `AXI_TYPEDEF_ALL_CT(axi_wide_out, axi_wide_out_req_t, axi_wide_out_rsp_t, axi_wide_out_addr_t,
                      axi_wide_out_id_t, axi_wide_out_data_t, axi_wide_out_strb_t,
                      axi_wide_out_user_t)



  /////////////////////////
  //   Header Typedefs   //
  /////////////////////////

  localparam route_algo_e RouteAlgo = XYRouting;
  localparam bit UseIdTable = 1'b1;
  localparam int unsigned NumXBits = 2;
  localparam int unsigned NumYBits = 2;
  localparam int unsigned XYAddrOffsetX = 29;
  localparam int unsigned XYAddrOffsetY = 31;
  localparam int unsigned IdAddrOffset = 0;


  typedef logic [3:0] rob_idx_t;
  typedef logic [1:0] x_bits_t;
  typedef logic [1:0] y_bits_t;
  typedef struct packed {
    x_bits_t x;
    y_bits_t y;
  } id_t;

  typedef logic route_t;
  typedef id_t dst_t;
  typedef logic [3:0] mask_id_t

  typedef struct packed {
    logic mcast_flag;
    logic rob_req;
    rob_idx_t rob_idx;
    mask_id_t dst_mask_id;
    dst_t dst_id;
    id_t src_id;
    logic last;
    logic atop;
    axi_ch_e axi_ch;
  } hdr_t;



  /////////////////////
  //   Address Map   //
  /////////////////////

  localparam int unsigned SamNumRules = 4;

  typedef struct packed {
    id_t idx;
    logic [47:0] start_addr;
    logic [47:0] end_addr;
  } sam_rule_t;

  localparam sam_rule_t [SamNumRules-1:0] Sam = '{
      '{
          idx: '{x: -1, y: 0},
          start_addr: 48'h000010000000,
          end_addr: 48'h000010003fff
      },  // cluster1_ni
      '{
          idx: '{x: 0, y: -1},
          start_addr: 48'h000010004000,
          end_addr: 48'h000010007fff
      },  // cluster2_ni
      '{
          idx: '{x: -1, y: -2},
          start_addr: 48'h000010008000,
          end_addr: 48'h00001000bfff
      },  // cluster3_ni
      '{
          idx: '{x: -2, y: -1},
          start_addr: 48'h00001000c000,
          end_addr: 48'h000010010000
      }  // cluster4_ni

  };


  ////////////////////////
  //   Flits Typedefs   //
  ////////////////////////

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_aw_chan_t aw;
  } floo_narrow_aw_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_w_chan_t w;
    logic [13:0] rsvd;
  } floo_narrow_w_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_b_chan_t b;
    logic [64:0] rsvd;
  } floo_narrow_b_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_ar_chan_t ar;
    logic [5:0] rsvd;
  } floo_narrow_ar_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_narrow_in_r_chan_t r;
  } floo_narrow_r_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_aw_chan_t aw;
    logic [490:0] rsvd;
  } floo_wide_aw_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_w_chan_t w;
  } floo_wide_w_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_b_chan_t b;
    logic [65:0] rsvd;
  } floo_wide_b_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_ar_chan_t ar;
    logic [6:0] rsvd;
  } floo_wide_ar_flit_t;

  typedef struct packed {
    hdr_t hdr;
    axi_wide_in_r_chan_t r;
    logic [58:0] rsvd;
  } floo_wide_r_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [90:0] rsvd;
  } floo_req_generic_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [74:0] rsvd;
  } floo_rsp_generic_flit_t;

  typedef struct packed {
    hdr_t hdr;
    logic [580:0] rsvd;
  } floo_wide_generic_flit_t;



  //////////////////////////
  //   Channel Typedefs   //
  //////////////////////////

  typedef union packed {
    floo_narrow_aw_flit_t narrow_aw;
    floo_narrow_w_flit_t narrow_w;
    floo_narrow_ar_flit_t narrow_ar;
    floo_wide_ar_flit_t wide_ar;
    floo_req_generic_flit_t generic;
  } floo_req_chan_t;

  typedef union packed {
    floo_narrow_b_flit_t narrow_b;
    floo_narrow_r_flit_t narrow_r;
    floo_wide_b_flit_t wide_b;
    floo_rsp_generic_flit_t generic;
  } floo_rsp_chan_t;

  typedef union packed {
    floo_wide_aw_flit_t wide_aw;
    floo_wide_w_flit_t wide_w;
    floo_wide_r_flit_t wide_r;
    floo_wide_generic_flit_t generic;
  } floo_wide_chan_t;



  ///////////////////////
  //   Link Typedefs   //
  ///////////////////////

  typedef struct packed {
    logic valid;
    logic ready;
    floo_req_chan_t req;
  } floo_req_t;

  typedef struct packed {
    logic valid;
    logic ready;
    floo_rsp_chan_t rsp;
  } floo_rsp_t;

  typedef struct packed {
    logic valid;
    logic ready;
    floo_wide_chan_t wide;
  } floo_wide_t;


endpackage
