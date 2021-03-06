function [input_omega] = controller(s,s_D,param) 
%input data : 
% s = [pos, vel, ang, omega]
% s_D = [pos_D, vel_D, acc_D, ang_psi_D, ome_psi_D]

K_zD = 2.5;
K_D = [1.75 ; 1.75 ; 1.75];
K_zP = 1.5;
K_P = [6 ; 6 ; 6];
s_D = state_D(s_D,param);

Thrust = param.m/(cos(s(7))*cos(s(8)))*(param.g + K_zD*(s_D.vel(3) - s(6)) + K_zP*(s_D.pos(3)-s(3)));
torq = param.I*(K_D.*(s_D.ome - s(10:12)) + K_P.*(s_D.ang - s(7:9)));

input_omega = [Thrust/(4*param.k)-torq(2)/(2*param.k*param.L)-torq(3)/(4*param.b);
               Thrust/(4*param.k)-torq(1)/(2*param.k*param.L)+torq(3)/(4*param.b);
               Thrust/(4*param.k)+torq(2)/(2*param.k*param.L)-torq(3)/(4*param.b);
               Thrust/(4*param.k)+torq(1)/(2*param.k*param.L)+torq(3)/(4*param.b);];
end