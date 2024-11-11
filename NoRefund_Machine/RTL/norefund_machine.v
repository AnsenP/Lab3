module norefund_machine(  
    input wire pi_money_one,  
    input wire pi_money_half,  
    input wire sys_clk,  
    input wire sys_rst_n,  
    output reg po_beverage,  
    output reg po_money  
);  

    reg [3:0] state;  
    wire [1:0] pi_money;  
 

    assign pi_money = {pi_money_one, pi_money_half};  

    parameter IDLE = 4'b0001;  
    parameter HALF = 4'b0010;  
    parameter ONE = 4'b0100;  
    parameter ONEHALF = 4'b1000;  

    always @(posedge sys_clk or negedge sys_rst_n) begin  
        if (!sys_rst_n) begin  
            state <= IDLE;  
        end else begin  
            case(state)  
                IDLE: begin  
                    if (pi_money == 2'b01)  
                        state <= HALF;  
                    else if (pi_money == 2'b10)  
                        state <= ONE;  
                    else  
                        state <= IDLE;  
                end  
                HALF: begin  
                    if (pi_money == 2'b01)  
                        state <= ONE;  
                    else if (pi_money == 2'b10)  
                        state <= ONEHALF;  
                    else  
                        state <= HALF;  
                end  
                ONE: begin  
                    if (pi_money == 2'b01)  
                        state <= ONEHALF;  
                    else if (pi_money == 2'b10)  
                        state <= IDLE;  
                    else  
                        state <= ONE;  
                end  
                ONEHALF: begin  
                    if (pi_money == 2'b01 || pi_money == 2'b10)  
                        state <= IDLE;  
                    else  
                        state <= ONEHALF;  
                end  
                default: state <= IDLE;  
            endcase  
        end  
    end  

    always @(posedge sys_clk or negedge sys_rst_n) begin  
        if (!sys_rst_n) begin  
            po_beverage <= 1'b0;  
        end else begin  
            if ((state == ONE && pi_money == 2'b10) ||   
                (state == ONEHALF && (pi_money == 2'b10 || pi_money == 2'b01)))  
                po_beverage <= 1'b1;  
            else   
                po_beverage <= 1'b0;  
        end  
    end  

    always@(posedge sys_clk or negedge sys_rst_n) begin
       if(sys_rst_n == 1'b0) begin
           po_money <= 1'b0;
       end else if((state == ONEHALF) && (pi_money == 2'b10)) begin
           po_money <= 1'b1;
       end else begin
           po_money <= 1'b0;
		 end
    end

endmodule 


