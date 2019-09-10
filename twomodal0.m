% clear the figure
clf;

% load the training set
load synth.tr;
Tr = synth;

% extract the samples belonging to different classes
I = find(Tr(:,3) == 0);  % find the row indices for the 1st class, labeled as 0
Tr0 = Tr(I,1:2);
save Tr0;                % so that you can use it directly next time 

I = find(Tr(:,3) == 1);  % find the row indices for the 2nd class, labeled as 1
Tr1 = Tr(I,1:2);
save Tr1;

% plot the samples
plot(Tr0(:,1),Tr0(:,2),'r*');
% use "red" for class 0
hold on;           % so that the future plots can be superimposed on the previous ones
plot(Tr1(:,1),Tr1(:,2),'go'); % use "green" for class 1

%
clear all;

% following is the estimate from class 0, the red samples
d = 2;    % two-dimensional
mu1 = [-0.75; 0.2];
mu2 = [0.3; 0.3];
S1 = [0.25 0; 0 0.3];
S2 = [0.1 0; 0 0.1];
A1 = 0.8;
A2 = 1 - A1;

nr = 1;     % row index
for i=-1.5:0.01:1
  nc = 1;   % column index
  for j=-0.2:0.01:1 
    x = [i;j];
    px1 = A1/((2*pi)^(d/2)*(det(S1))^(1/2)) * exp(-1/2*(x - mu1)'*inv(S1)*(x-mu1));
    px2 = A2/((2*pi)^(d/2)*(det(S2))^(1/2)) * exp(-1/2*(x - mu2)'*inv(S2)*(x-mu2));
    px(nr,nc) = px1 + px2;
    nc = nc + 1;
 end
 nr = nr + 1;
end

[m,n] = size(px);

xindex = repmat([-1.5:0.01:1]',1,n);
yindex = repmat([-0.2:0.01:1],m,1);
xlabel('xs') 
ylabel('ys') 
title('Bimodal Gaussian Distribution for Class 0')
contour(xindex,yindex,px);
legend({'Class 0','Class 1','distribution'},'Location','northwest')


