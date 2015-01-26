function []=test_NB(name)
MFCCs=calcmfcc(name);
MFCCs_trans=MFCCs';
%size(MFCCs)
%numberOfClusters=4;
%[~,clusterCentroids]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);
load('cluster.mat');
test_bagOfWords= findBagofWords(clusterCentroids,MFCCs_trans);%finds bag of words for 1st person

test_bagOfWords=test_bagOfWords/size(MFCCs_trans,1);
cd test/
save('test.mat','test_bagOfWords')