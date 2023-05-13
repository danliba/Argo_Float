%%writing excel
path0='D:\CIO';
fn='Pesca_imarpe.mat';

load(fullfile(path0,fn));

a=cat(1,fecha1,fecha2);
b=datestr(a);
fecha=cellstr(b);

pesca=cat(1,pesca1,pesca2);
viajes=cat(1,viajes1,viajes2);
promedio=cat(1,promedios1,promedios2);

xlswrite('datos.xls',fecha,'A2:A71');

datos=cat(2,pesca,viajes,promedio);
xlswrite('datos.xls',datos,'B2:D71');
