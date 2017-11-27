module matrix(clk,rst,a00,a01,a02,a03,a10,a11,a12,a13,a20,a21,a22,a23,a30,a31,a32,a33,b0,b1,b2,b3,c0,c1,c2,c3,p,t);
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101,s6=3'b110,s7=3'b111;
input clk,rst;
input [6:0] a00,a01,a02,a03,a10,a11,a12,a13,a20,a21,a22,a23,a30,a31,a32,a33;
input [6:0] b0,b1,b2,b3;
output reg [17:0] c0,c1,c2,c3;
output reg [17:0]p,t;
reg[17:0] q,r,s;
reg [3:0] count,count1;
reg [2:0] state,next_state;

/*initial
begin
p=18'd0;
q=18'd0;
r=18'd0;
s=18'd0;
c0=18'd0;
c1=18'd0;
c2=18'd0;
c2=18'd0;
end*/

always@(posedge clk)
begin
if (rst)
count<=4'd0;
else if (count==4'd7)
count<=4'd0;
else
count<=count+1;
end

always@(posedge clk)
begin
if(rst==1'b1)
state<=s0;
else
state<=next_state;
end

always@(state)
begin
case(state)
 
  
s0:
  begin
   module mul(input [] a, b, output [] o);
    assign o= a*b;
   endmodule
 
  wire [] a00xb0;
  mul ma00xb0(.a(a00), .b(b0), .o(a00xb0));
 
  p = a00xb0;
  next_state=s1;
  end
  
s1:
  begin
   p=p+(a01*b1);
   q=a10*b0;
   next_state=s2;
  end
s2:
  begin
   p=p+(a02*b2);
   q=q+(a11*b1);
   r=a20*b0;
   next_state=s3;
  end
s3:
  begin
   p=p+(a03*b3);
   q=q+(a12*b2);
   r=r+(a21*b1);
   s=a30*b0;
   c0=p;
   next_state=s4;
  end
s4:
  begin
   q=q+(a13*b3);
   r=r+(a22*b2);
   s=s+(a31*b1);
   c1=q;
   next_state=s5;
  end
s5:
  begin
   r=r+(a23*b3);
   s=s+(a32*b2);
   c2=r;
   next_state=s6;
 end
s6:
  begin
   s=s+(a33*b3);
   c3=s;
   next_state=s0;
  end
default:
  begin
  next_state=s0;
end

endcase
end
endmodule
