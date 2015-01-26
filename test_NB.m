function []=test_NB()

%size(MFCCs)
%numberOfClusters=4;
%[~,clusterCentroids]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);
load('cluster.mat');

A=dir('*.wav')
MFCCs_trans_test=cell(length(A),1);
temp_test_array=[];
for i=1:length(A),
    name=A(i).name;
    MFCCs=calcmfcc(name);
    MFCCs_trans_test{i}=MFCCs';
    temp_test_array=[temp_test_array;MFCCs_trans_test{i}];
end
for j = 1:length(A)
    test_bagOfWords(j,:)= findBagofWords( clusterCentroids,MFCCs_trans_test{j}); %finds bag of words for 1st person
    %temp_norm= findBagofWords( clusterCentroids,MFCCs_trans{1});
    
    test_bagOfWords(j,:)=test_bagOfWords(j,:)/sum(test_bagOfWords(j,:));
    
    %temp_norm_after=bagOfWords(1,:)/sum(bagOfWords(1,:));
    %labels(j,1) = 1;
end
    %size(MFCCs_trans_test)
    %test_bagOfWords= findBagofWords(clusterCentroids,MFCCs_trans_test);%finds bag of words for 1st person

    %test_bagOfWords=test_bagOfWords/size(MFCCs_trans,1);

save('test.mat','test_bagOfWords')