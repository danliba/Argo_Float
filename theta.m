function pt = theta(s,t,p,pr)
% THETA Potential temperature of seawater.
%
% pt = theta(s,t,p,pr) Computes the local potential temperature
% following Fofonoff and Millard (1983)(UNESCO). If pr is omitted
% pr = 0.0 is assumed.
%
% Input parameters:
%     salinity           s [ppt]
%     temperature        t [degC]
%     in situ pressure   p [dbar]
%     reference pressure pr [dbar]
%
% Output parameters:
%     potential temperature tp [degC]
%

% References: 
% 1) Fofonoff, N.P, and R.C. Millard Jr., 1983, Algorithms
% for computation of fundamental properties of seawater, UNESCO
% Technical Papers in Marine Science, Vol. 44, 53 pp.
% 2) Fofonoff, N., 1977: Deep-Sea Res., 24, 489-491.
% 

% Fabian Wolk 1999/08/01
% 2001 Alec Electronics Co., Ltd.
% #Revision 0.0: 2001/08/09#

error(nargchk(3,4,nargin));
if ~all(size(t)==size(s))
   error('Vector dimensions must agree.');
end
if ~all(size(s)==size(p))
   error('Vector dimensions must agree.');
end

h = pr-p;
xk = h.*atg(s,t,p);
t = t + 0.5*xk;
q = xk;
p = p + 0.5*h;
xk = h.*atg(s,t,p);
t = t + 0.29289322*(xk-q);
q = 0.58578644*xk + 0.121320344*q;
xk = h.*atg(s,t,p);
t = t + 1.707106781*(xk-q);
q = 3.414213562*xk - 4.121320344*q;
p = p + 0.5*h;
xk = h.*atg(s,t,p);
pt = t + (xk-2.0*q)/6.0;
