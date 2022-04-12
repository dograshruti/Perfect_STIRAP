%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% user parameters have same names as in the article 
%"Perfect stimulated Raman adiabatic passage with imperfect finite-time pulses, 
% Shruti Dogra and Gheorghe Sorin Paraoanu". Ref. arXiv:2204.05271
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
clc

% Flags
sigma_r_map=1; % 1: 2D map as a function of r and sigma
% These definitions are as per paper %
set1=1;  % No condition on r
set2=0;  % with r condition
set3=0;  % old


% user defined values
n_r = 31; % Number of points in r_range
n_s = 21; % Number of points in sigma_range

r_range=linspace(0.1,3,n_r);

if (sigma_r_map==1)
sigma_range=linspace(10,50,n_s)*1e-9;
else
sigma_range=30e-9;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% matlab code main_STIRAP_and_saSTIRAP runs from here %

for loop1=1:length(r_range)
    for loop2=1:length(sigma_range)
        r_ext=r_range(loop1);
        sigma_ext=sigma_range(loop2);
       Main_STIRAP_and_saSTIRAP 
       
pop1_sr(loop1,loop2)=xr(end,1);
pop2_sr(loop1,loop2)=xr(end,2);
pop3_sr(loop1,loop2)=xr(end,3);
time_log(loop1,loop2)=timetaken;
omega_log(loop1,loop2)=omega;
    end
end

%%

if (loop2>=2)
figure
X1=r_range;
Y1=sigma_range*1e9;
Z=squeeze(pop3_sr(:,:));
[X,Y] = meshgrid(Y1,X1);
h1=surf(X, Y, Z)
% view([90 -90]);
caxis([0,1])
colormap('jet')
colorbar
shading 'flat'
else
    figure(11)
    hold on
plot(r_range,squeeze(pop3_sr(:,1)))
end


%%
o01t=omega01.*exp(-t.^2/2/sigma^2);
o12t=omega12.*exp(-(t-ts).^2/2/sigma^2);
ap=sqrt(o01t.^2+o12t.^2);
td=-ts/sigma^2*o01t.*o12t./ap.^2;

figure
plot(t,o01t, t,o12t, t, ap, t,td)
%%
if (loop2>=2)
figure
X1=r_range;
Y1=sigma_range*1e9;
Z=squeeze(time_log);
[X,Y] = meshgrid(Y1,X1);
h1=surf(X, Y, Z);
view([90 -90]);
colorbar
shading 'flat'

figure
Z=squeeze(omega_log*1e-6);
[X,Y] = meshgrid(Y1,X1);
h1=surf(X, Y, Z);
view([90 -90]);
colorbar
shading 'flat'

else
figure
plot(r_range, time_log)
hold on
%figure
plot(r_range, omega_log*1e-6)
end
%%
figure
plot(r_range, sigma*omega_log)





