function [T,rho,p,a] = ISA(Hgeo)

%% parameters -----------------------------------------------
H1 = 11*10^3;           % 圏界面[m]
b  = -0.0065;           % 温度勾配[K/m]
p0 = 1013.25;           % 0[m]の気圧[hPa]
T0 = 288.15;            % 0[m]の温度[K]
p1 = 226.55;            % 11000[m]の気圧[hpa]
T1 = T0+b*H1;          % 11000[m]の温度[K]
R  = 287.05;            % 空気の気体定数[J/kg/K]
g0 = 9.80665;           % 重力定数[m/s^2]
kappa = 1.4;            % 空気の比熱比
rho0 = 1.225;           % 地上での大気密度[kg/m^3]
rho1 = 0.3643;          % 11000[m]の大気密度[kg/m^3]
%------------------------------------------------------------

lb2kg = 0.45359237;
ft2km = 0.3048*10^(-3);

%%%%%%%%%%%%%%%%%%　標準大気モデル（ISA） %%%%%%%%%%%%%%%%%%
Hgeo0=0;

if (Hgeo<=H1)
    T   = T0+b*(Hgeo-Hgeo0);
    p   = p0*(T/T0)^(-g0/R/b); %hPa
    rho = p*10^2/R/T;
elseif(Hgeo>H1)
    T  = 216.65;
    p  = p1*exp(-g0/R/T*(Hgeo-H1)); %hPa
    rho = p*10^2./R./T;
else
    T = NaN;
    p = NaN;
    rho = NaN;
end

a = sqrt(kappa*R*T);
