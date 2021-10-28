`timescale 1ns / 1ps

module fsm_time(
    clk, reset, ped_button, em_button,
    TGN, TGE, TGS, TGW, 
    state, count, 
    N_color, E_color, S_color, W_color, 
    n_count, e_count, s_count, w_count, t_count
    );
    
    input clk;
    input reset;
    input ped_button;
    input em_button;
    input [7:0] TGN, TGE, TGS, TGW;
    
    output reg [3:0] state;
    output reg [7:0] count;
    output reg [7*7:0] N_color, E_color, S_color, W_color;
    output reg [7:0] n_count, e_count, s_count, w_count, t_count;
    
    reg flag;
    reg ped, em;
    
    parameter Tcycle = 80;
    parameter TO = 10;
      
    
    always @(posedge clk or em_button) begin
        if (!reset) begin
                ped = 0;
                em = 0;
                N_color = "Red";
                E_color = "Red";
                S_color = "Red";
                W_color = "Red";
                state = 0;
                count = 0;
                t_count = Tcycle - 1;
                n_count = TGN-1; 
                e_count = TGN + TO;
                s_count = TGN + TGE + TO + TO;
                w_count = TGN + TGE + TGS + TO + TO + TO;
                flag = 1;
        end
        else begin
            if (em_button)
                em = 1;
            if (ped_button)
                ped = 1;
                           
            if (count==0) begin
                if (!flag) begin               
                    if (state==7)
                        state = 0;
                    else
                        state = state+1;
                end
                        
                case(state)
                    0: begin N_color <= "Green"; 
                             n_count = TGN-1; 
                             w_count <= Tcycle-(TGW+TO) -1;
                             e_count <= e_count - 1;
                             s_count <= s_count - 1; 
                             count = n_count; 
                             W_color <= "Red"; 
                       end
                    1: begin N_color = "Orange"; 
                             n_count = TO-1;
                             e_count <= e_count - 1;
                             s_count <= s_count - 1; 
                             w_count <= w_count - 1;
                             count = n_count; 
                       end
                    2: begin E_color = "Green"; 
                             e_count = TGE-1; 
                             n_count = Tcycle-(TGN+TO)-1;
                             w_count <= w_count - 1;
                             s_count <= s_count - 1; 
                             count = e_count; 
                             N_color = "Red"; 
                       end
                    3: begin E_color = "Orange"; 
                             e_count = TO-1;
                             n_count <= n_count - 1;
                             s_count <= s_count - 1;
                             w_count <= w_count - 1; 
                             count = e_count; 
                       end
                    4: begin S_color = "Green"; 
                             s_count = TGS-1; 
                             e_count = Tcycle-(TGE+TO)-1;
                             w_count <= w_count - 1;
                             n_count <= n_count - 1; 
                             count = s_count; 
                             E_color = "Red"; 
                       end
                    5: begin S_color = "Orange"; 
                             s_count = TO-1;
                             n_count <= n_count - 1;
                             e_count <= e_count - 1;
                             w_count <= w_count - 1; 
                             count = s_count; 
                       end
                    6: begin W_color = "Green"; 
                             w_count = TGW-1; 
                             s_count = Tcycle-(TGS+TO)-1;
                             n_count <= n_count - 1;
                             e_count <= e_count - 1; 
                             count = w_count; 
                             S_color = "Red"; 
                       end
                    7: begin W_color = "Orange"; 
                             w_count = TO-1;
                             n_count <= n_count - 1;
                             s_count <= s_count - 1;
                             e_count <= e_count - 1; 
                             count = w_count; 
                       end
                endcase
                
                flag = 0;
        
                end
            else begin
                count = count - 1;
                n_count = n_count - 1;
                e_count = e_count - 1;
                s_count = s_count - 1;
                w_count = w_count - 1;
            end
            
            if (t_count == 0)
                t_count = Tcycle-1;
            else
                t_count = t_count-1;
        end 
    end
endmodule
