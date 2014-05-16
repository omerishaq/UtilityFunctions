clear all
close all

Data = rand(500,2);
[ReturnData, k] = sortParetoFrontsMinimally( Data );

figure; hold on;
Lin = {'+r', '+b', '+g'};
for i = 1:k-1;
    d = rem(i,3);
    Datap = Data(ReturnData(i).F,:);
    plot(Datap(:,1), Datap(:,2), Lin{d+1});
    
end