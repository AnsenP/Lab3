`timescale 1ns/1ns  
module tb_refund_machine();  

////  
//* Parameter and Internal Signal *//  
////  

// reg define  
reg sys_clk;  
reg sys_rst_n;  
reg pi_money_one;  
reg pi_money_half;  
reg random_data_gen;  

// wire define  
wire po_beverage;  
wire po_money_one;  
wire po_money_half;  

////  
//* Main Code *//  
////  

// Initialize system clock and global reset  
initial begin  
    sys_clk = 1'b1;  
    sys_rst_n <= 1'b0;  
    #20  
    sys_rst_n <= 1'b1;  
	 #65
	 sys_rst_n <= 1'b0;
	 #5
	 sys_rst_n <= 1'b1;
	 #153
	 sys_rst_n <= 1'b0;
	 #5
	 sys_rst_n <= 1'b1;
end  

// sys_clk: Simulate system clock, toggle every 10ns, period 20ns, frequency 50MHz  
always #10 sys_clk = ~sys_clk;  

// random_data_gen: Generate random number 0 or 1  
always @(posedge sys_clk or negedge sys_rst_n)  
    if (sys_rst_n == 1'b0)  
        random_data_gen <= 1'b0;  
    else  
        random_data_gen <= {$random} % 2;  

// pi_money_one: Simulate inserting 1 unit of money  
always @(posedge sys_clk or negedge sys_rst_n)  
    if (sys_rst_n == 1'b0)  
        pi_money_one <= 1'b0;  
    else  
        pi_money_one <= random_data_gen;  

// pi_money_half: Simulate inserting 0.5 unit of money  
always @(posedge sys_clk or negedge sys_rst_n)  
    if (sys_rst_n == 1'b0)  
        pi_money_half <= 1'b0;  
    else  
        // Ensure only one coin type is inserted at a time  
        pi_money_half <= ~random_data_gen;  

//------------------------------------------------------------  
// Monitor the internal signals for observation  
wire [3:0] state = refund_machine_inst.state;  
wire [1:0] pi_money = refund_machine_inst.pi_money;  
wire [1:0] po_money = refund_machine_inst.po_money;

initial begin  
    $timeformat(-9, 0, "ns", 6);  
    $monitor("@time %t: pi_money_one=%b pi_money_half=%b pi_money=%b state=%b po_beverage=%b po_money_one=%b po_money_half=%b",  
             $time, pi_money_one, pi_money_half, pi_money, state, po_beverage, po_money_one, po_money_half);  
end  
//------------------------------------------------------------  

////  
//* Instantiation *//  
////  

//------------------------norefund_machine_inst------------------------  
refund_machine refund_machine_inst(  
    .sys_clk (sys_clk),          // input sys_clk  
    .sys_rst_n (sys_rst_n),      // input sys_rst_n  
    .pi_money_one (pi_money_one), // input pi_money_one  
    .pi_money_half (pi_money_half), // input pi_money_half  

    .po_beverage (po_beverage),  // output po_beverage  
    .po_money_one (po_money_one), // output po_money_one  
    .po_money_half (po_money_half) // output po_money_half  
);  

endmodule