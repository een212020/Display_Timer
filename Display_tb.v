`timescale 1ns / 1ps

module Display_tb;
    
    reg clk, reset, ped_button, em_button;
    reg [7:0] TGi0, TGi1, TGi2, TGi3;
    
    wire [3:0] state;
    wire [7:0] count;
    wire [7*7:0] N_color, E_color, S_color, W_color;
    wire [7:0] n_count, e_count, s_count, w_count, t_count;
    wire [7:0] TG0, TG1, TG2, TG3;
    wire [6:0] n_msb, n_lsb, e_msb, e_lsb, s_msb, s_lsb, w_msb, w_lsb;
    
    initial begin
            clk = 0 ;
//            em_button = 0;
//            ped_button = 0;
            TGi0 = 6;
            TGi1 = 6;
            TGi2 = 6;
            TGi3 = 6;
            reset = 0; #4
            reset = 1;
            #1000;
    
//            em_button = 1; #1
//            em_button = 0; #315
//            ped_button = 1; 
//            ped_button = 0;#200
            $finish;
        end
    
        Display DUT(clk, reset, ped_button, em_button, 
                    TGi0, TGi1, TGi2, TGi3,
                    state, count,
                    TG0, TG1, TG2, TG3, 
                    N_color, E_color, S_color, W_color, 
                    n_count, e_count, s_count, w_count, t_count,
                    n_msb, n_lsb, e_msb, e_lsb, s_msb, s_lsb, w_msb, w_lsb 
                    );
         
    always #1 clk = ~clk;
    
endmodule
