function []=test_NB(name)
MFCCs=calcmfcc(name);
MFCCs_trans=MFCCs;
numberOfCluster=4;
[~,clusterCentroids]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);  
test_bagOfWords= findBagofWords(clusterCentroids,MFCCs_trans); %finds bag of words for 1st person
save('test.mat','test_bagOfWords')