`timescale 1ns / 1ps

module Display(
    clk, reset, ped_button, em_button, 
    TGi0, TGi1, TGi2, TGi3,
    state, count,
    TG0, TG1, TG2, TG3, 
    N_color, E_color, S_color, W_color, 
    n_count, e_count, s_count, w_count, t_count,
    n_msb, n_lsb, e_msb, e_lsb, s_msb, s_lsb, w_msb, w_lsb 
    );
    
    input clk, reset, ped_button, em_button;
    input [7:0] TGi0, TGi1, TGi2, TGi3;
    
    output wire [3:0] state;
    output wire [7:0] count;
    output wire [7*7:0] N_color, E_color, S_color, W_color;
    output wire [7:0] n_count, e_count, s_count, w_count, t_count;
    output wire [7:0] TG0, TG1, TG2, TG3;
    output wire [6:0] n_msb, n_lsb, e_msb, e_lsb, s_msb, s_lsb, w_msb, w_lsb;   

    rounder R0(TGi0, TG0);
    rounder R1(TGi1, TG1);
    rounder R2(TGi2, TG2);
    rounder R3(TGi3, TG3);

    
    fsm_time F1(clk, reset, ped_button, em_button, 
                TG0, TG1, TG2, TG3,
                state, count, 
                N_color, E_color, S_color, W_color, 
                n_count, e_count, s_count, w_count, t_count);
                
    to_seven_seg S1(n_count, n_msb, n_lsb);
    to_seven_seg S2(e_count, e_msb, e_lsb);
    to_seven_seg S3(s_count, s_msb, s_lsb);
    to_seven_seg S4(w_count, w_msb, w_lsb);
    
endmodule
