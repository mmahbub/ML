clf;
% load the training set
load synth.tr;
train = synth;

% extract the samples belonging to different classes
I = find(train(:,3) == 0);  % find the row indices for the 1st class, labeled as 0
train0 = train(I,1:2);
save train0;                % so that you can use it directly next time 

I = find(train(:,3) == 1);  % find the row indices for the 2nd class, labeled as 1
train1 = train(I,1:2);
save train1;

% plot the testing dataset
plot(train0(:,1), train0(:,2), 'r*', train1(:,1), train1(:,2), 'go')
hold on

% derivation of decision rule
syms x1;
syms x2;
feat = [x1;x2];
d = 2;
mean0 = [-0.22147024; 0.32575494];
mean1 = [0.07595431; 0.68296891];

%case I:
detercov0 = 0.005685938154625601;
detercov1 = detercov0;
inversecov0 = [13.26169191 0; 0 13.26169191];
inversecov1 = inversecov0;
prob0 = .5;
prob1 = 1-prob0;

px0 = (1/((2*pi)^(d/2)*sqrt(detercov0)))*exp(-.5*transpose(feat - mean0)*inversecov0*(feat - mean0))*prob0;
px1 = (1/((2*pi)^(d/2)*sqrt(detercov1)))*exp(-.5*transpose(feat - mean1)*inversecov1*(feat - mean1))*prob1;
px=px0-px1
plt1 = fimplicit(px0-px1, [-2 1.5 -2 1.5])


% Case II:
detercov0 = 0.00971469812566908;
detercov1 = detercov0;
inversecov0 = [3.68823704 -1.14659565; -1.14659565 28.26594031];
inversecov1 = inversecov0;

px0 = (1/((2*pi)^(d/2)*sqrt(detercov0)))*exp(-.5*transpose(feat - mean0)*inversecov0*(feat - mean0))*prob0;
px1 = (1/((2*pi)^(d/2)*sqrt(detercov1)))*exp(-.5*transpose(feat - mean1)*inversecov1*(feat - mean1))*prob1;
px=px0-px1
plt2 = fimplicit(px0-px1, [-2 1.5 -2 1.5])


% Case III:
detercov0 = 0.00971469812566908;
detercov1 = 0.0044708112510173205;
inversecov0 = [3.68823704 -1.14659565; -1.14659565 28.26594031];
inversecov1 = [6.6472831 3.45583997; 3.45583997 35.44544123];

px0 = (1/((2*pi)^(d/2)*sqrt(detercov0)))*exp(-.5*transpose(feat - mean0)*inversecov0*(feat - mean0))*prob0;
px1 = (1/((2*pi)^(d/2)*sqrt(detercov1)))*exp(-.5*transpose(feat - mean1)*inversecov1*(feat - mean1))*prob1;
px=px0-px1
plt3 = fimplicit(px0-px1, [-2 1.5 -2 1.5])


set(plt1, 'Color', 'm');
set(plt2, 'Color', 'c');
set(plt3, 'Color', 'b');
xlabel('xs') 
ylabel('ys') 
title('Decision Boundaries for Train Data')
legend({'Class 0','Class 1','Case I','Case II','Case III'},'Location','southwest')
